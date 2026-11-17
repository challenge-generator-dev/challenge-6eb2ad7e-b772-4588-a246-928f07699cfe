# Variables de entorno para el despliegue de la API de pedidos

variable "environment" {
  description = "Entorno de despliegue (ej: dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, staging, prod."
  }
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda para la API de pedidos"
  type        = string
  default     = "orders-api-lambda"
}

variable "lambda_description" {
  description = "Descripción de la función Lambda"
  type        = string
  default     = "Lambda para manejar las solicitudes de la API de pedidos"
}

variable "lambda_runtime" {
  description = "Runtime de la función Lambda"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_handler" {
  description = "Handler de la función Lambda"
  type        = string
  default     = "index.handler"
}

variable "lambda_filename" {
  description = "Ruta al archivo ZIP que contiene el código de la función Lambda"
  type        = string
  default     = "../lambda/orders-api.zip"
}

variable "lambda_memory_size" {
  description = "Memoria asignada a la función Lambda en MB"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Timeout de la función Lambda en segundos"
  type        = number
  default     = 10
}

variable "lambda_environment_variables" {
  description = "Variables de entorno para la función Lambda"
  type        = map(string)
  default = {
    ENVIRONMENT = "dev"
    LOG_LEVEL   = "info"
  }
}

variable "api_gateway_name" {
  description = "Nombre del API Gateway para la app de pedidos"
  type        = string
  default     = "orders-api-gateway"
}

variable "api_gateway_description" {
  description = "Descripción del API Gateway"
  type        = string
  default     = "API Gateway para la app de pedidos"
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage de despliegue del API Gateway"
  type        = string
  default     = "dev"
}

variable "api_paths" {
  description = "Paths que expondrá el API Gateway para la app de pedidos"
  type        = list(string)
  default     = ["orders", "orders/{id}"]
}

variable "api_http_methods" {
  description = "Métodos HTTP para cada path del API Gateway"
  type        = list(string)
  default     = ["GET", "POST", "PUT", "DELETE"]
}

variable "log_retention_days" {
  description = "Días de retención para los logs de CloudWatch"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags para los recursos de AWS"
  type        = map(string)
  default = {
    Project     = "orders-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}