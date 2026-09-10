data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_src/lambda_function.py"
  output_path = "${path.module}/build/lambda_function.zip"
}
# Created explicitly so retention is bounded and `terraform destroy` removes it.
# Lambda would otherwise auto-create this group with never-expire retention.
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.lambda_log_retention_days
}
resource "aws_lambda_function" "lambda_over_https" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_apigateway_role.arn
  runtime          = "python3.13"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  depends_on = [
    aws_iam_role_policy_attachment.lambda_custom_policy,
    aws_cloudwatch_log_group.lambda,
  ]
}