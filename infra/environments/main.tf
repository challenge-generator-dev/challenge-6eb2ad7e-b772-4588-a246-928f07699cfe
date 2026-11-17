# Aprovisionamiento de recursos para la app de pedidos
# Utiliza los módulos de API Gateway y Lambda

terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Módulo de Lambda
module "lambda" {
  source = "../modules/lambda"

  function_name = "pedidos-handler"
  description   = "Función Lambda para manejar pedidos de la app"
  runtime       = "nodejs18.x"
  handler       = "index.handler"
  filename      = "lambda/pedidos-function.zip"
  memory_size   = 256
  timeout       = 30

  environment_variables = {
    ENVIRONMENT = "production"
    LOG_LEVEL   = "info"
    DB_HOST     = "pedidos-db.example.com"
    DB_PORT     = "5432"
    DB_NAME     = "pedidos"
  }

  log_retention_days = 14

  api_gateway_execution_arn = module.api_gateway.api_gateway_execution_arn
}

# Módulo de API Gateway
module "api_gateway" {
  source = "../modules/api_gateway"

  api_name               = "pedidos-api"
  description            = "API Gateway para la app de pedidos móviles"
  stage_name             = "prod"
  lambda_invoke_arn      = module.lambda.lambda_invoke_arn
  lambda_function_name   = module.lambda.lambda_function_name
  path_parts             = ["orders", "users", "products"]
  http_methods           = ["GET", "POST", "PUT", "DELETE"]
}

# Integración adicional para conectar API Gateway con Lambda
# Esta integración explícita asegura la conexión correcta
# TODO(reto): implementa este bloque
# resource "aws_api_gateway_integration" "lambda_integration" {
# }

resource "aws_api_gateway_resource" "orders" {
  rest_api_id = module.api_gateway.api_gateway_id
  parent_id   = module.api_gateway.api_gateway_id
  path_part   = "orders"
}

resource "aws_api_gateway_method" "orders_get" {
  rest_api_id   = module.api_gateway.api_gateway_id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "orders_lambda" {
  rest_api_id = module.api_gateway.api_gateway_id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = "GET"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.lambda_invoke_arn
}

# Permiso adicional para API Gateway
# TODO(reto): implementa este bloque
# resource "aws_lambda_permission" "apigw_lambda" {
# }

# Validación de configuración antes del despliegue
locals {
  validate_lambda_arn = can(regex("^arn:aws:lambda:us-east-1:[0-9]{12}:function:", module.lambda.lambda_arn))
  validate_api_id     = can(regex("^[a-z0-9]{10,}$", module.api_gateway.api_gateway_id))
}

# Outputs para verificación
output "deployment_status" {
  description = "Estado del despliegue de infraestructura"
  value = {
    api_gateway_url = module.api_gateway.api_gateway_invoke_url
    lambda_arn      = module.lambda.lambda_arn
    lambda_name     = module.lambda.lambda_function_name
    log_group       = module.lambda.log_group_name
    validation      = local.validate_lambda_arn && local.validate_api_id ? "SUCCESS" : "FAILED"
  }
}