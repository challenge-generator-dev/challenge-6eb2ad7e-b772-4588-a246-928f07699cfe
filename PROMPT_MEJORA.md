# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/modules/api_gateway/main.tf` — La pieza p1 (Definición de módulos reutilizables en Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- `infra/environments/main.tf` — La pieza p3 (Aprovisionamiento de recursos con Terraform, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `client/lib/presentation/blocs/orders_bloc.dart` — La pieza p4 (Implementación de pull-to-refresh con Bloc, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `client` expone http (api: https://{api_gateway_id}.execute-api.{region}.amazonaws.com/{stage}):
  - `GET /orders`

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `infra/tests/acceptance/f1.tftest.hcl`
- `infra/tests/acceptance/f2.tftest.hcl`

### Referencias no verificadas

Referencias no verificadas para: .dart. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando.

## Como saber que terminaste

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuracion inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto. — entregable (NO resolver): Configuracion de Terraform lista para el proyecto.
- Fase 2: Despliegue de la API con Terraform — objetivo: Desplegar la API de la app de pedidos usando Terraform. — entregable (NO resolver): Definición de infraestructura como código para desplegar la API con Terraform, incluyendo módulos para API Gateway y Lambda, y pruebas de aceptación que validen el despliegue.
- Fase 3: Verificacion de la funcionalidad pull-to-refresh — objetivo: Verificar que el listado de pedidos soporta pull-to-refresh y que las pruebas de aceptacion lo verifican. — entregable (NO resolver): Funcionalidad pull-to-refresh verificada y pruebas de aceptacion actualizadas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/README.md ===
# Terraform AWS Infrastructure

## Overview
This repository contains Terraform configurations to provision AWS infrastructure for a serverless application using Lambda and API Gateway.

## Structure
```
.
├── environments/          # Environment-specific configurations
│   ├── dev/               # Development environment
│   │   └── terraform.tfvars
│   ├── main.tf            # Root module entry point
│   └── variables.tf       # Input variables for root module
├── modules/               # Reusable Terraform modules
│   ├── api_gateway/       # API Gateway module
│   └── lambda/            # Lambda function module
└── tests/                 # Test configurations
    └── acceptance/        # Acceptance tests
        ├── f1.tftest.hcl
        └── f2.tftest.hcl
```

## Prerequisites
- Terraform 1.7.5
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create Lambda, API Gateway, and IAM resources

## Setup
1. Initialize Terraform:
```bash
terraform init
```

2. Review the execution plan for the development environment:
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

3. Apply the configuration:
```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

## Testing
Run acceptance tests:
```bash
terraform test
```

## Validation
After applying the configuration, verify:
- Lambda function is created in AWS Console
- API Gateway endpoint is accessible
- Resources match the expected configuration in `terraform.tfvars`

## Cleanup
Destroy provisioned resources:
```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/modules/lambda/main.tf ===
# Módulo reutilizable para desplegar funciones Lambda en AWS
# Provee recursos para Lambda, permisos IAM y logging

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description   = var.description
  role          = aws_iam_role.lambda_exec.arn
  runtime       = var.runtime
  handler       = var.handler
  filename      = var.filename
  memory_size   = var.memory_size
  timeout       = var.timeout
  environment {
    variables = var.environment_variables
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda_logs
  ]
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
}

// === ARCHIVO: infra/modules/lambda/variables.tf ===
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

// === ARCHIVO: infra/modules/lambda/outputs.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/variables.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/outputs.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
# Módulo de API Gateway para la app de pedidos
# Proporciona un API Gateway REST con integración a Lambda

# TODO(reto): implementa este bloque
# resource "aws_api_gateway_rest_api" "this" {
# }

# TODO(reto): implementa este bloque
# resource "aws_api_gateway_deployment" "this" {
# }

# TODO(reto): implementa este bloque
# resource "aws_api_gateway_stage" "this" {
# }

# TODO(reto): implementa este bloque
# resource "aws_api_gateway_account" "this" {
# }

# TODO(reto): implementa este bloque
# resource "aws_iam_role" "api_gateway_cloudwatch" {
# }

# TODO(reto): implementa este bloque
# resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch" {
# }

# Recursos para cada path configurado
# TODO(reto): implementa este bloque
# resource "aws_api_gateway_resource" "this" {
# }

# Métodos HTTP para cada recurso
# TODO(reto): implementa este bloque
# resource "aws_api_gateway_method" "this" {
# }

# Integración con Lambda
# TODO(reto): implementa este bloque
# resource "aws_api_gateway_integration" "lambda_integration" {
# }

# Permiso para que API Gateway invoque Lambda
# TODO(reto): implementa este bloque
# resource "aws_lambda_permission" "apigw_lambda" {
# }

// === ARCHIVO: infra/environments/main.tf ===
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

// === ARCHIVO: infra/environments/variables.tf ===
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

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/orders_repository_impl.dart';
import 'presentation/blocs/orders_bloc.dart';
import 'presentation/screens/orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => OrdersBloc(
          ordersRepository: OrdersRepositoryImpl(
            httpClient: http.Client(),
          ),
        )..add(const LoadOrders()),
        child: const OrdersScreen(),
      ),
    );
  }
}

// === ARCHIVO: client/pubspec.yaml ===
name: reto
description: Reto de aprendizaje.
publish_to: none
version: 1.0.0+1

environment:
  sdk: ">=3.12.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  equatable: 3.0.0
  flutter_bloc: 9.1.1
  http: 1.6.0
  mocktail: 1.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: 10.0.0

flutter:
  uses-material-design: true

// === ARCHIVO: client/analysis_options.yaml ===
analyzer:
  exclude:
    - _pendiente/**

// === ARCHIVO: client/lib/domain/repositories/orders_repository.dart ===
import 'package:flutter/foundation.dart';

abstract class OrdersRepository {
  Future<List<OrderDto>> getOrders();
  Future<List<OrderDto>> refreshOrders();
}

@immutable
class OrderDto {
  final String id;
  final String status;
  final List<OrderItemDto> items;

  const OrderDto({
    required this.id,
    required this.status,
    required this.items,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          listEquals(items, other.items);

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ items.hashCode;
}

@immutable
class OrderItemDto {
  final String productId;
  final int quantity;
  final double price;

  const OrderItemDto({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemDto &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          quantity == other.quantity &&
          price == other.price;

  @override
  int get hashCode =>
      productId.hashCode ^ quantity.hashCode ^ price.hashCode;
}

class OrdersRepositoryException implements Exception {
  final String message;
  final Exception? cause;

  OrdersRepositoryException(this.message, [this.cause]);

  @override
  String toString() => 'OrdersRepositoryException: $message${cause != null ? ' (Causa: $cause)' : ''}';
}

// === ARCHIVO: client/lib/presentation/blocs/orders_bloc.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/orders_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

/// BLoC para manejar el estado del listado de pedidos.
/// Implementa el patrón BLoC para gestión de estado en Flutter,
/// siguiendo las convenciones del proyecto (no usar GetX).
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(const OrdersInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<RefreshOrdersEvent>(_onRefreshOrders);
  }

  /// Maneja el evento de carga inicial de pedidos.
  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(const OrdersLoading());
    try {
      final orders = await _ordersRepository.getOrders();
      emit(OrdersLoaded(orders: orders));
    } on OrdersRepositoryException catch (e) {
      emit(OrdersError(message: e.message));
    } catch (e) {
      emit(OrdersError(message: 'Error al cargar los pedidos: $e'));
    }
  }

  /// Maneja el evento de pull-to-refresh para actualizar la lista de pedidos.
  /// Este método es el símbolo exclusivo de la pieza p4.
  Future<void> _onRefreshOrders(
    RefreshOrdersEvent event,
    Emitter<OrdersState> emit,
  ) async {
    final currentState = state;
    
    // Mantener los datos actuales mientras se refresca
    if (currentState is OrdersLoaded) {
      emit(OrdersRefreshing(orders: currentState.orders));
    } else {
      emit(const OrdersLoading());
    }

    try {
      final orders = await _ordersRepository.refreshOrders();
      emit(OrdersLoaded(orders: orders));
    } on OrdersRepositoryException catch (e) {
      // En caso de error, mantener los datos anteriores si existen
      if (currentState is OrdersLoaded) {
        emit(OrdersError(
          message: e.message,
          orders: currentState.orders,
        ));
      } else {
        emit(OrdersError(message: e.message));
      }
    } catch (e) {
      if (currentState is OrdersLoaded) {
        emit(OrdersError(
          message: 'Error al refrescar los pedidos: $e',
          orders: currentState.orders,
        ));
      } else {
        emit(OrdersError(message: 'Error al refrescar los pedidos: $e'));
      }
    }
  }

  /// Método público para dispara el refresh de pedidos.
  /// Este es el símbolo público que la UI invoca para pull-to-refresh.
  Future<void> refreshOrders() async {
    throw UnimplementedError('TODO(reto): refreshOrders');
  }

  /// Método interno para obtener pedidos.
  /// Este es un símbolo exclusivo de esta pieza.
  Future<void> _fetchOrders() async {
    throw UnimplementedError('TODO(reto): _fetchOrders');
  }
}

// === ARCHIVO: client/lib/presentation/blocs/orders_event.dart ===
part of 'orders_bloc.dart';

/// Clase base abstracta para los eventos del OrdersBloc.
abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista de pedidos.
class LoadOrders extends OrdersEvent {
  const LoadOrders();
}

/// Evento para refrescar la lista de pedidos (pull-to-refresh).
/// Este evento es el que se dispara cuando el usuario hace pull-to-refresh
/// en el listado de pedidos.
class RefreshOrdersEvent extends OrdersEvent {
  const RefreshOrdersEvent();
}

// === ARCHIVO: client/lib/presentation/blocs/orders_state.dart ===
part of 'orders_bloc.dart';

/// Clase base abstracta para los estados del OrdersBloc.
abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial cuando el BLoC se acaba de crear.
class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

/// Estado mientras se están cargando los pedidos.
class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

/// Estado cuando los pedidos se han cargado correctamente.
class OrdersLoaded extends OrdersState {
  final List<OrderDto> orders;

  const OrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

/// Estado mientras se están refrescando los pedidos (pull-to-refresh en progreso).
class OrdersRefreshing extends OrdersState {
  final List<OrderDto> orders;

  const OrdersRefreshing({required this.orders});

  @override
  List<Object?> get props => [orders];
}

/// Estado cuando ocurre un error al cargar o refrescar los pedidos.
class OrdersError extends OrdersState {
  final String message;
  final List<OrderDto>? orders;

  const OrdersError({
    required this.message,
    this.orders,
  });

  @override
  List<Object?> get props => [message, orders];
}

// === ARCHIVO: client/test/acceptance/f3_test.dart ===
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reto/domain/repositories/orders_repository.dart';
import 'package:reto/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  late MockOrdersRepository mockOrdersRepository;

  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
  });

  group('OrdersBloc - Pull-to-Refresh (f3)', () {
    final testOrders = [
      OrderDto(
        id: 'order-1',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 2, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 1, price: 25.0),
        ],
      ),
    ];

    final refreshedOrders = [
      OrderDto(
        id: 'order-1',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 2, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 1, price: 25.0),
        ],
      ),
      OrderDto(
        id: 'order-3',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-3', quantity: 3, price: 15.0),
        ],
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'should_refresh_orders_on_pull_to_refresh',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      seed: () => OrdersLoaded(orders: testOrders),
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        isA<OrdersRefreshing>().having(
          (s) => s.orders,
          'orders',
          testOrders,
        ),
        isA<OrdersLoaded>().having(
          (s) => s.orders,
          'orders',
          refreshedOrders,
        ),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'should_handle_error_on_refresh_failure',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Error de red'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      seed: () => OrdersLoaded(orders: testOrders),
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        isA<OrdersRefreshing>().having(
          (s) => s.orders,
          'orders',
          testOrders,
        ),
        isA<OrdersError>()
            .having((s) => s.message, 'message', 'Error de red')
            .having((s) => s.orders, 'orders', testOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'should_show_loading_when_refresh_fails_without_previous_data',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Timeout'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>().having(
          (s) => s.message,
          'message',
          'Timeout',
        ),
      ],
    );
  });
}

// === ARCHIVO: client/lib/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    
    <application
        android:label="reto"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/repositories/orders_repository_impl.dart ===
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final http.Client _httpClient;
  final String _baseUrl;

  OrdersRepositoryImpl({
    http.Client? httpClient,
    String? baseUrl,
  })  : _httpClient = httpClient ?? http.Client(),
        _baseUrl = baseUrl ?? 'https://api.example.com/prod';

  @override
  Future<List<OrderDto>> getOrders() async {
    try {
      final uri = Uri.parse('$_baseUrl/orders');
      final response = await _httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => _parseOrderDto(item as Map<String, dynamic>))
            .toList();
      } else {
        throw OrdersRepositoryException(
          'Error al obtener pedidos: código de estado ${response.statusCode}',
        );
      }
    } on OrdersRepositoryException {
      rethrow;
    } catch (e) {
      throw OrdersRepositoryException(
        'Error de red al obtener pedidos',
        e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  OrderDto _parseOrderDto(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>;
    final items = itemsList
        .map((item) => _parseOrderItemDto(item as Map<String, dynamic>))
        .toList();

    return OrderDto(
      id: json['id'] as String,
      status: json['status'] as String,
      items: items,
    );
  }

  OrderItemDto _parseOrderItemDto(Map<String, dynamic> json) {
    return OrderItemDto(
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }
}

// === ARCHIVO: client/lib/presentation/screens/orders_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/orders_bloc.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(
        ordersRepository: context.read<OrdersRepository>(),
      )..add(const LoadOrders()),
      child: const OrdersView(),
    );
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersInitial || state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrdersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrdersBloc>().add(const LoadOrders());
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (state is OrdersLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<OrdersBloc>().refreshOrders();
              },
              child: state.orders.isEmpty
                  ? _buildEmptyState()
                  : _buildOrdersList(state),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: const [
        SizedBox(height: 100),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No hay pedidos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList(OrdersLoaded state) {
    return ListView.builder(
      itemCount: state.orders.length,
      itemBuilder: (context, index) {
        final order = state.orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pedido #${order.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    _buildStatusChip(order.status),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '${order.items.length} artículo(s)',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: \$${_calculateTotal(order).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'entregado':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'pending':
      case 'pendiente':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      case 'cancelled':
      case 'cancelado':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  double _calculateTotal(OrderDto order) {
    return order.items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}

// === ARCHIVO: client/test/orders_bloc_test.dart ===
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reto/domain/repositories/orders_repository.dart';
import 'package:reto/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  late MockOrdersRepository mockRepository;
  late OrdersBloc ordersBloc;

  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  setUp(() {
    mockRepository = MockOrdersRepository();
    ordersBloc = OrdersBloc(ordersRepository: mockRepository);
  });

  tearDown(() {
    ordersBloc.close();
  });

  group('OrdersBloc - Carga de pedidos', () {
    final testOrders = [
      OrderDto(
        id: 'order-1',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 2, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 1, price: 25.0),
        ],
      ),
    ];

    test('estado inicial es OrdersInitial', () {
      expect(ordersBloc.state, const OrdersInitial());
    });

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersLoaded] cuando LoadOrders tiene éxito',
      build: () {
        when(() => mockRepository.getOrders())
            .thenAnswer((_) async => testOrders);
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadOrders()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoaded(orders: testOrders),
      ],
      verify: (_) {
        verify(() => mockRepository.getOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersError] cuando LoadOrders falla',
      build: () {
        when(() => mockRepository.getOrders())
            .thenThrow(OrdersRepositoryException('Error de red'));
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadOrders()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>(),
      ],
    );
  });

  group('OrdersBloc - Pull-to-refresh', () {
    final refreshedOrders = [
      OrderDto(
        id: 'order-refreshed',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-new', quantity: 3, price: 15.0),
        ],
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersLoaded] cuando RefreshOrdersEvent tiene éxito',
      build: () {
        when(() => mockRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoaded(orders: refreshedOrders),
      ],
      verify: (_) {
        verify(() => mockRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersError] cuando RefreshOrdersEvent falla',
      build: () {
        when(() => mockRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Timeout'));
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>(),
      ],
    );

    test('refreshOrders() método público dispara RefreshOrdersEvent', () async {
      when(() => mockRepository.refreshOrders())
          .thenAnswer((_) async => refreshedOrders);
      
      final bloc = OrdersBloc(ordersRepository: mockRepository);
      
      await bloc.refreshOrders();
      
      verify(() => mockRepository.refreshOrders()).called(1);
      await bloc.close();
    });
  });
}

// === ARCHIVO: client/test/acceptance/orders_refresh_test.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../lib/domain/repositories/orders_repository.dart';
import '../../lib/presentation/blocs/orders_bloc.dart';
import '../../lib/presentation/screens/orders_screen.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  group('Acceptance: Pull-to-refresh en OrdersScreen', () {
    late MockOrdersRepository mockRepository;
    late OrdersBloc ordersBloc;

    final initialOrders = [
      OrderDto(
        id: 'order-1',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 1, price: 10.0),
        ],
      ),
    ];

    final refreshedOrders = [
      OrderDto(
        id: 'order-1',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 1, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 2, price: 20.0),
        ],
      ),
    ];

    setUp(() {
      mockRepository = MockOrdersRepository();
      when(() => mockRepository.getOrders())
          .thenAnswer((_) async => initialOrders);
      when(() => mockRepository.refreshOrders())
          .thenAnswer((_) async => refreshedOrders);
      ordersBloc = OrdersBloc(ordersRepository: mockRepository);
    });

    tearDown(() {
      ordersBloc.close();
    });

    testWidgets(
      'pull-to-refresh actualiza la lista de pedidos correctamente',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('order-1'), findsOneWidget);
        expect(find.text('pending'), findsOneWidget);

        await tester.pump();

        ordersBloc.add(const RefreshOrdersEvent());
        
        await tester.pumpAndSettle();

        expect(find.text('completed'), findsOneWidget);
        expect(find.text('order-2'), findsOneWidget);
        expect(find.text('shipped'), findsOneWidget);

        verify(() => mockRepository.refreshOrders()).called(1);
      },
    );

    testWidgets(
      'el estado se maneja con Bloc y no con GetX',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(ordersBloc.state, isA<OrdersLoaded>());

        final state = ordersBloc.state as OrdersLoaded;
        expect(state.orders, equals(initialOrders));
      },
    );

    testWidgets(
      'RefreshIndicator está presente en la UI',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RefreshIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'mostrar indicador de carga durante el refresh',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        ordersBloc.add(const RefreshOrdersEvent());
        await tester.pump();

        expect(ordersBloc.state, const OrdersLoading());

        await tester.pumpAndSettle();

        expect(ordersBloc.state, isA<OrdersLoaded>());
      },
    );
  });
}
```
