# Variables de salida del módulo Lambda

output "lambda_arn" {
  description = "ARN de la función Lambda creada"
  value       = aws_lambda_function.this.arn
}

output "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  value       = aws_lambda_function.this.invoke_arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.this.function_name
}

output "lambda_role_arn" {
  description = "ARN del rol IAM asociado a la función Lambda"
  value       = aws_iam_role.lambda_exec.arn
}

output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}