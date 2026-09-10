output "api_gateway_rest_api_id" {
  description = "ID for use with `aws apigateway --rest-api-id`."
  value       = aws_api_gateway_rest_api.dynamodb_operations.id
}
output "api_invoke_url" {
  description = "Invoke URL for POST /DynamoDBManager."
  value       = "${aws_api_gateway_stage.prod.invoke_url}${aws_api_gateway_resource.dynamodb_manager.path}"
}
output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.lambda_over_https.arn
}
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table."
  value       = aws_dynamodb_table.lambda_apigateway.name
}
output "lambda_role_arn" {
  description = "ARN of the Lambda execution role."
  value       = aws_iam_role.lambda_apigateway_role.arn
}