variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}
variable "lambda_function_name" {
  description = "Name of the Lambda function."
  type        = string
  default     = "LambdaFunctionOverHttps"
}
variable "lambda_log_retention_days" {
  description = "CloudWatch Logs retention for the Lambda log group, in days."
  type        = number
  default     = 7
}
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table."
  type        = string
  default     = "lambda-apigateway"
}
variable "dynamodb_read_capacity" {
  description = "Provisioned read capacity units for the DynamoDB table."
  type        = number
  default     = 1
}
variable "dynamodb_write_capacity" {
  description = "Provisioned write capacity units for the DynamoDB table."
  type        = number
  default     = 1
}
variable "api_name" {
  description = "Name of the REST API."
  type        = string
  default     = "DynamoDBOperations"
}
variable "api_stage_name" {
  description = "Deployment stage name for the REST API."
  type        = string
  default     = "Prod"
}