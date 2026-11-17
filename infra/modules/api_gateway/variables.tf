# Variables de entrada para el módulo API Gateway

variable "api_name" {
  description = "Nombre del API Gateway"
  type        = string
}

variable "description" {
  description = "Descripción del API Gateway"
  type        = string
  default     = ""
}

variable "stage_name" {
  description = "Nombre del stage de despliegue (ej: dev, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_invoke_arn" {
  description = "ARN de invocación de la Lambda que integrará este API Gateway"
  type        = string
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda que integrará este API Gateway"
  type        = string
}

variable "path_parts" {
  description = "Lista de paths que expondrá el API Gateway (ej: ['orders', 'users'])"
  type        = list(string)
  default     = []
}

variable "http_methods" {
  description = "Lista de métodos HTTP para cada path (ej: ['GET', 'POST'])"
  type        = list(string)
  default     = ["GET"]
}