resource "aws_api_gateway_rest_api" "dynamodb_operations" {
  name = var.api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
resource "aws_api_gateway_resource" "dynamodb_manager" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations.id
  parent_id   = aws_api_gateway_rest_api.dynamodb_operations.root_resource_id
  path_part   = "DynamoDBManager"
}
resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.dynamodb_operations.id
  resource_id   = aws_api_gateway_resource.dynamodb_manager.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations.id
  resource_id = aws_api_gateway_resource.dynamodb_manager.id
  http_method = aws_api_gateway_method.post.http_method
  # Lambda proxy/non-proxy integrations are always invoked with POST.
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda_over_https.invoke_arn
}
resource "aws_api_gateway_method_response" "post_200" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations.id
  resource_id = aws_api_gateway_resource.dynamodb_manager.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = "200"
}
resource "aws_api_gateway_integration_response" "post_200" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations.id
  resource_id = aws_api_gateway_resource.dynamodb_manager.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = aws_api_gateway_method_response.post_200.status_code
  depends_on  = [aws_api_gateway_integration.lambda]
}
resource "aws_lambda_permission" "apigateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_over_https.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.dynamodb_operations.execution_arn}/*/${aws_api_gateway_method.post.http_method}${aws_api_gateway_resource.dynamodb_manager.path}"
}
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.dynamodb_operations.id
  # Force a new deployment whenever the API definition changes.
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.dynamodb_manager.id,
      aws_api_gateway_method.post.id,
      aws_api_gateway_integration.lambda.id,
      aws_api_gateway_integration_response.post_200.id,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_api_gateway_stage" "prod" {
  rest_api_id   = aws_api_gateway_rest_api.dynamodb_operations.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.api_stage_name
}