# AWS Lambda Power Tuning

## Reference
- [aws-lambda-power-tuning](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:451282441545:applications~aws-lambda-power-tuning)


## How to use

### Deploy with Terraform

- Set the target region in `terraform.tfvars`.
- Optional tuning parameters (power values, execution timeout, visualization URL) are commented out in `lambda_power_tuner.tf`. Configure them if necessary.
- Deploy with `terraform apply`

