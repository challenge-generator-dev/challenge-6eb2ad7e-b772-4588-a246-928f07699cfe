# Terraform variables for dev environment
aws_region = "us-east-1"

# Lambda configuration
lambda_function_name = "dev-lambda-function"
lambda_runtime       = "nodejs18.x"
lambda_handler       = "index.handler"
lambda_memory_size   = 128
lambda_timeout       = 3

# API Gateway configuration
api_gateway_name        = "dev-api-gateway"
api_gateway_description = "API Gateway for dev environment"
api_gateway_stage_name  = "dev"

# Tags
environment = "dev"