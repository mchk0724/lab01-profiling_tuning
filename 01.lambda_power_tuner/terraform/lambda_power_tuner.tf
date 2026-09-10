resource "aws_serverlessapplicationrepository_cloudformation_stack" "lambda-power-tuning" {
  name             = "lambda-power-tuner"
  application_id   = "arn:aws:serverlessrepo:us-east-1:451282441545:applications/aws-lambda-power-tuning"
  capabilities     = ["CAPABILITY_IAM"]
  # Uncomment the next line to deploy a specific version
  # semantic_version = "4.4.0"

  parameters = {
    # All of these parameters are optional and are only shown here for demonstration purposes
    # See https://github.com/alexcasalboni/aws-lambda-power-tuning/blob/master/README-INPUT-OUTPUT.md#state-machine-input-at-deployment-time
    # PowerValues           = "128,192,256,512,1024,2048,3072,4096,5120,6144,7168,8192,9216,10240"
    # lambdaResource        = "*"
    # totalExecutionTimeout = 900
    # visualizationURL      = "https://lambda-power-tuning.show/"
  }
}