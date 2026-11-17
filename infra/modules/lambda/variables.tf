# Variables de entrada para el módulo Lambda

variable "function_name" {
  description = "Nombre único de la función Lambda"
  type        = string
}

variable "description" {
  description = "Descripción de la función Lambda"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Runtime de la función Lambda (ej: nodejs18.x, python3.9)"
  type        = string
}

variable "handler" {
  description = "Handler de la función Lambda (ej: index.handler)"
  type        = string
}

variable "filename" {
  description = "Ruta al archivo ZIP que contiene el código de la función"
  type        = string
}

variable "memory_size" {
  description = "Memoria asignada a la función Lambda en MB"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Timeout de la función Lambda en segundos"
  type        = number
  default     = 3
}

variable "environment_variables" {
  description = "Variables de entorno para la función Lambda"
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "Días de retención para los logs de CloudWatch"
  type        = number
  default     = 7
}

variable "api_gateway_execution_arn" {
  description = "ARN del API Gateway que invocará esta Lambda (opcional)"
  type        = string
  default     = ""
}