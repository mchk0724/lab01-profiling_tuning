region = "us-east-1"

api_name       = "DynamoDBOperations"
api_stage_name = "Prod"

lambda_function_name = "LambdaFunctionOverHttps"

dynamodb_table_name     = "lambda-apigateway"
dynamodb_read_capacity  = 1
dynamodb_write_capacity = 1

# Log retention in days. Must be one of the values CloudWatch allows:
# 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827,
# 2192, 2557, 2922, 3288, 3653. Use 0 for never expire.
lambda_log_retention_days = 7
