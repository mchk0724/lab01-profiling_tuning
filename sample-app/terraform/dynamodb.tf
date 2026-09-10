resource "aws_dynamodb_table" "lambda_apigateway" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  hash_key       = "id"
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  attribute {
    name = "id"
    type = "S"
  }
}