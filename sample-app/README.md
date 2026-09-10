# Sample App

Sample app with minimal serverless CRUD stack: a REST API that invokes a Lambda function, which performs DynamoDB operations chosen by the request body.

## 1. Architecture overview
```

     POST /DynamoDBManager

     (JSON body describes the operation)

                │

                ▼

   ┌─────────────────────────────┐

   │ API Gateway (REST, REGIONAL)│  DynamoDBOperations

   │   stage: Prod               │  authorization: NONE

   └──────────────┬──────────────┘

                  │  AWS integration (non-proxy)

                  │  body passed through as the event

                  ▼

   ┌─────────────────────────────┐

   │ Lambda                      │  LambdaFunctionOverHttps

   │   python3.13                │  role: lambda-apigateway-role

   │   lambda_function.lambda_handler

   └───────┬─────────────────┬───┘

           │ boto3           │ logs

           ▼                 ▼

   ┌───────────────┐  ┌──────────────────┐

   │ DynamoDB      │  │ CloudWatch Logs  │

   │ lambda-       │  │ /aws/lambda/...  │

   │ apigateway    │  │ 7-day retention  │

   │ PK: id (S)    │  └──────────────────┘

   └───────────────┘

```



## 2. How to use

### Deploy with Terraform

- To change names, region, capacity, or log retention, edit `terraform.tfvars` 
- Deploy with `terraform apply`

### Invoke

```bash
API_URL=$(terraform output -raw api_invoke_url)

# Health check — no DynamoDB access
curl -s -X POST "$API_URL" -d '{"operation":"ping"}'

# Create an item
curl -s -X POST "$API_URL" -d '{
  "operation": "create",
  "tableName": "lambda-apigateway",
  "payload": {"Item": {"id": "1", "number": 5}}
}'

# Read it back
curl -s -X POST "$API_URL" -d '{
  "operation": "read",
  "tableName": "lambda-apigateway",
  "payload": {"Key": {"id": "1"}}
}'

# List every item
curl -s -X POST "$API_URL" -d '{
  "operation": "list",
  "tableName": "lambda-apigateway",
  "payload": {}
}'

# Delete it
curl -s -X POST "$API_URL" -d '{
  "operation": "delete",
  "tableName": "lambda-apigateway",
  "payload": {"Key": {"id": "1"}}
}'
```

 
