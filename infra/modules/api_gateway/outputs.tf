# Variables de salida del módulo API Gateway

output "api_gateway_id" {
  description = "ID del API Gateway creado"
  value = null # TODO(reto): aws_api_gateway_rest_api.this.id
}

output "api_gateway_arn" {
  description = "ARN del API Gateway"
  value = null # TODO(reto): aws_api_gateway_rest_api.this.arn
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway (usado para permisos Lambda)"
  value = null # TODO(reto): aws_api_gateway_rest_api.this.execution_arn
}

output "api_gateway_invoke_url" {
  description = "URL base para invocar el API Gateway"
  value = null # TODO(reto): "${aws_api_gateway_deployment.this.invoke_url}${var.stage_name}"
}

output "api_gateway_stage_name" {
  description = "Nombre del stage desplegado"
  value       = var.stage_name
}