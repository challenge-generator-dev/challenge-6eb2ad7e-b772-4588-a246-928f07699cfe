# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Despliegue de la API de la app de pedidos con Terraform**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el backend de una app movil |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Terraform (AWS) |
| Stack | HCL / Terraform |
| Patron arquitectonico | modulos reutilizables con separacion de responsabilidades |
| Tiempo estimado | 8 horas |

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

## Receta del stack

Esqueleto obligatorio:

- `main.tf con los recursos`
- `variables.tf con las variables (sin default)`
- `outputs.tf con los valores expuestos`
- `versions.tf con required_version y required_providers`
- `environments/dev/terraform.tfvars con los valores`
- `README.md con la topologia y como validar (init -backend=false, validate)`

Trampas conocidas:

- NUNCA incluyas `apply`, `destroy` ni `deploy` (terraform apply/destroy, cdk deploy/destroy, sam deploy, aws cloudformation deploy) en README, scripts ni instrucciones: el reto se valida y se revisa, no se despliega.
- Cero credenciales hardcodeadas: nada de claves `AKIA...`, `aws_secret_access_key` ni `secret_key` literales. La autenticacion la resuelve el entorno del candidato (perfil o variables de entorno), nunca el codigo.
- Sin backend remoto real: nada de `backend "s3"` con un bucket concreto. Usa estado local (`backend "local"`) o no declares backend; la verificacion corre con `init -backend=false`.
- `versions.tf` declara `required_version` como RANGO (`>= 1.5`) y `required_providers` con `source = "hashicorp/aws"` y `version = "~> 5.0"` (una version que exista); nunca versiones exactas.
- Las variables de `variables.tf` NO llevan `default`: todos los valores van en `environments/dev/terraform.tfvars`.
- Para leer recursos que ya existen usa data sources (`aws_kms_key`, `aws_iam_role`, `aws_dynamodb_table`...) por nombre o alias, nunca `terraform_remote_state`.
- El codigo tiene que pasar `terraform fmt -check`: indentacion de 2 espacios y `=` alineados dentro de cada bloque.

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuracion inicial de Terraform**: Configuracion de Terraform lista para el proyecto.
- **Fase 2 — Despliegue de la API con Terraform**: Definición de infraestructura como código para desplegar la API con Terraform, incluyendo módulos para API Gateway y Lambda, y pruebas de aceptación que validen el despliegue.
- **Fase 3 — Verificacion de la funcionalidad pull-to-refresh**: Funcionalidad pull-to-refresh verificada y pruebas de aceptacion actualizadas.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/modules/api_gateway/main.tf` — La pieza p1 (Definición de módulos reutilizables en Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `infra/environments/main.tf` — La pieza p3 (Aprovisionamiento de recursos con Terraform, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `client/lib/presentation/blocs/orders_bloc.dart` — La pieza p4 (Implementación de pull-to-refresh con Bloc, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).

## Mapa de fases

La **Fase 0** es clonar el repositorio, instalar dependencias y correr las pruebas de aceptacion: todas fallan porque la logica de cada pieza esta pendiente.

| Fase | Pieza (skill) | Archivo:simbolo | Criterios | Prueba | Comando |
|------|---------------|-----------------|-----------|--------|---------|
| f1 — Configuracion inicial de Terraform | Configuración de backend remoto para Terraform | — | El proyecto Terraform está inicializado con backend remoto configurado; Los módulos reutilizables para API Gateway y Lambda están definidos en directorios separados | — | — |
| f1 — Configuracion inicial de Terraform | Definición de módulos reutilizables para API Gateway | — | El proyecto Terraform está inicializado con backend remoto configurado; Los módulos reutilizables para API Gateway y Lambda están definidos en directorios separados | — | — |
| f2 — Despliegue de la API con Terraform | Definición de módulos reutilizables para Lambda | `infra/environments/main.tf:modules.lambda` | La API de la app de pedidos está desplegada usando Terraform con módulos reutilizables; Los recursos de AWS (API Gateway y Lambda) se crean correctamente y están disponibles para la app móvil | — | — |
| f2 — Despliegue de la API con Terraform | Orquestación de módulos para despliegue de la API | `client/lib/presentation/blocs/orders_bloc.dart:api_deployment.deploy` | La API de la app de pedidos está desplegada usando Terraform con módulos reutilizables; Los recursos de AWS (API Gateway y Lambda) se crean correctamente y están disponibles para la app móvil | — | — |
| f3 — Verificacion de la funcionalidad pull-to-refresh | Implementación de pull-to-refresh con Bloc | — | El listado de pedidos en la app móvil soporta pull-to-refresh; Las pruebas de aceptación verifican que el gesto pull-to-refresh dispara la recarga de pedidos | `client/test/acceptance/f3_test.dart` | `cd client && flutter test test/acceptance/f3_test.dart` |
| f3 — Verificacion de la funcionalidad pull-to-refresh | Integración de pull-to-refresh en la UI con Bloc | — | El listado de pedidos en la app móvil soporta pull-to-refresh; Las pruebas de aceptación verifican que el gesto pull-to-refresh dispara la recarga de pedidos | `client/test/acceptance/f3_test.dart` | `cd client && flutter test test/acceptance/f3_test.dart` |

## Pruebas de aceptacion y ubicacion de la logica

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

La logica de cada pieza va en su archivo; no la muevas a otro.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos reutilizables de Terraform para API Gateway y Lambda (un directorio por modulo) | chequeo estatico (code): exige `module "api_gateway"`, `module "lambda"`, `source = "./modules/api_gateway"`, `source = "./modules/lambda"` | Restriccion no verificada en chequeo estatico (code): exige `module "api_gateway"`, `module "lambda"`, `source = "./modules/api_gateway"`, `source = "./modules/lambda"` |
| No usar GetX en la app Flutter; el estado se maneja con Bloc (dependencia flutter_bloc en pubspec.yaml) | chequeo estatico (code): exige `flutter_bloc`, `BlocProvider`, `BlocBuilder`; prohibe `getx`, `Get.put`, `Get.find` | Verificada |
| El listado de pedidos soporta pull-to-refresh y las pruebas de aceptacion lo verifican | sin ubicar | Restriccion no verificada en sin ubicar |

## Lo que falta y tenes que completar

Referencias no verificadas para: .dart. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando. Corre el comando de verificacion para encontrarlas.

### 1. Archivos que la arquitectura declara (2 de 18)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `infra/tests/acceptance/f1.tftest.hcl`
- [ ] `infra/tests/acceptance/f2.tftest.hcl`

### Presentes (25)

- `infra/README.md`
- `infra/environments/dev/terraform.tfvars`
- `infra/versions.tf`
- `infra/providers.tf`
- `infra/modules/lambda/main.tf`
- `infra/modules/lambda/variables.tf`
- `infra/modules/lambda/outputs.tf`
- `infra/modules/api_gateway/variables.tf`
- `infra/modules/api_gateway/outputs.tf`
- `infra/modules/api_gateway/main.tf`
- `infra/environments/main.tf`
- `infra/environments/variables.tf`
- `client/lib/main.dart`
- `client/pubspec.yaml`
- `client/analysis_options.yaml`
- `client/lib/domain/repositories/orders_repository.dart`
- `client/lib/presentation/blocs/orders_bloc.dart`
- `client/lib/presentation/blocs/orders_event.dart`
- `client/lib/presentation/blocs/orders_state.dart`
- `client/test/acceptance/f3_test.dart`
- `client/lib/android/app/src/main/AndroidManifest.xml`
- `client/lib/data/repositories/orders_repository_impl.dart`
- `client/lib/presentation/screens/orders_screen.dart`
- `client/test/orders_bloc_test.dart`
- `client/test/acceptance/orders_refresh_test.dart`

### Capas del patron declarado

Son las capas que la propuesta arquitectonica plantea, marcadas segun existan hoy en el repo. Orientan donde poner el codigo nuevo; no son una condicion para compilar.

- `infra` (presente)
- `infra/modules/api_gateway` (presente)
- `infra/modules/lambda` (presente)
- `infra/environments` (presente)
- `client` (presente)
- `client/lib/domain` (presente)
- `client/lib/data` (presente)
- `client/lib/presentation` (presente)
- `client/test` (presente)

## Verificacion

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **modulos reutilizables con separacion de responsabilidades**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform para la app movil
- Mision: Desplegar la API de la app de pedidos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
