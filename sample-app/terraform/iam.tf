data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "lambda_apigateway_role" {
  name               = "lambda-apigateway-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
data "aws_iam_policy_document" "lambda_custom_policy" {
  statement {
    sid    = "Stmt1428341300017"
    effect = "Allow"
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "lambda_custom_policy" {
  name   = "lambda-custom-policy"
  policy = data.aws_iam_policy_document.lambda_custom_policy.json
}
resource "aws_iam_role_policy_attachment" "lambda_custom_policy" {
  role       = aws_iam_role.lambda_apigateway_role.name
  policy_arn = aws_iam_policy.lambda_custom_policy.arn
}