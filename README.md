# Despliegue de la API de la app de pedidos con Terraform

Aprovisiona con Terraform los recursos que consume la aplicacion movil. Usa modulos reutilizables de Terraform para API Gateway y Lambda (un directorio por modulo). No uses GetX en la app Flutter; el estado se maneja con Bloc (dependencia flutter_bloc en pubspec.yaml). El listado de pedidos soporta pull-to-refresh y las pruebas de aceptacion lo verifican.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Tener el proyecto base del reto funcionando en tu máquina: clonar el repositorio, instalar las herramientas y verificar que compila y arranca antes de empezar a practicar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Instala las herramientas para ejecutar el proyecto: Flutter/Dart SDK · Terraform 1.5+.
- Clona el repositorio del reto (el enlace viene en la entrega del reto y en la sección "Repositorio del Proyecto" del PDF) y ábrelo en tu IDE.
- Instala las dependencias y compila ejecutando `(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` en la raíz del repositorio.
- Confirma que el comando termina sin errores: el proyecto arranca y sus pruebas corren.
- Ubica los archivos de práctica: son los que contienen `TODO(reto)` (búscalos en el repositorio). Lee el README.md y el AGENTS.md antes de empezar.

**Entregable:** El proyecto compila/arranca sin errores con `(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)`.

<details>
<summary>Pistas de conocimiento</summary>

- Los archivos con `TODO(reto)` son el ejercicio: el resto del repositorio ya está resuelto y no hace falta tocarlo.
- Si el comando de verificación falla, revisa la versión de las herramientas instaladas antes de modificar código.
- AGENTS.md describe el reto, el comando de verificación y las reglas del repositorio.

</details>

### Fase 1: Configuracion inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura Terraform para el proyecto de la app movil.
- Crea los modulos reutilizables para API Gateway y Lambda.

**Entregable:** Configuracion de Terraform lista para el proyecto.

<details>
<summary>Pistas de conocimiento</summary>

- Usa Terraform para definir la infraestructura como codigo.
- Organiza los modulos de Terraform en directorios separados.

</details>

### Fase 2: Despliegue de la API con Terraform

**Objetivo:** Desplegar la API de la app de pedidos usando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Implementa la pieza `p3` en el componente `infra` para definir los recursos de AWS (API Gateway y Lambda) usando los módulos reutilizables creados en `f1`.
- Implementa la pieza `p4` en el componente `infra` para declarar el despliegue de la API como un caso de uso de infraestructura, con responsabilidades exclusivas sobre la orquestación de módulos.
- Asegúrate de que las pruebas de aceptación de `p4` validen que los recursos se despliegan correctamente y que los módulos se integran según lo esperado.
- Verifica que los casos de aceptación incluyan al menos dos escenarios de error (ej: fallo en la creación de Lambda o API Gateway).

**Entregable:** Definición de infraestructura como código para desplegar la API con Terraform, incluyendo módulos para API Gateway y Lambda, y pruebas de aceptación que validen el despliegue.

<details>
<summary>Pistas de conocimiento</summary>

- Usa Terraform para desplegar los recursos de la API.
- Verifica que el estado de la app se maneje correctamente con Bloc.

</details>

### Fase 3: Verificacion de la funcionalidad pull-to-refresh

**Objetivo:** Verificar que el listado de pedidos soporta pull-to-refresh y que las pruebas de aceptacion lo verifican.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Verifica que el listado de pedidos en la app movil soporta pull-to-refresh.
- Asegurate de que las pruebas de aceptacion verifican esta funcionalidad.

**Entregable:** Funcionalidad pull-to-refresh verificada y pruebas de aceptacion actualizadas.

<details>
<summary>Pistas de conocimiento</summary>

- Verifica la funcionalidad pull-to-refresh en la app movil.
- Actualiza las pruebas de aceptacion para asegurar que verifican esta funcionalidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Que es Terraform y como se usa para desplegar infraestructura como codigo?
- **paraQueSirve**: ¿Para que sirve usar modulos reutilizables en Terraform?
- **comoSeUsa**: ¿Como se usa Terraform para desplegar una API de una app movil?
- **erroresComunes**: ¿Que errores comunes puedes encontrar al desplegar una API con Terraform y como los solucionas?
- **queDecisionesImplica**: ¿Que decisiones debes tomar para asegurar que el listado de pedidos soporta pull-to-refresh y que las pruebas de aceptacion lo verifican?

## Criterios de Evaluacion

- Configuracion inicial de Terraform realizada correctamente.
- Modulos reutilizables de Terraform creados y organizados en directorios separados.
- API de la app de pedidos desplegada con Terraform.
- Estado de la app manejado con Bloc y no con GetX.
- Funcionalidad pull-to-refresh verificada en el listado de pedidos.
- Pruebas de aceptacion actualizadas para verificar la funcionalidad pull-to-refresh.

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

## Pruebas de aceptacion

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos reutilizables de Terraform para API Gateway y Lambda (un directorio por modulo) | chequeo estatico (code): exige `module "api_gateway"`, `module "lambda"`, `source = "./modules/api_gateway"`, `source = "./modules/lambda"` | Restriccion no verificada en chequeo estatico (code): exige `module "api_gateway"`, `module "lambda"`, `source = "./modules/api_gateway"`, `source = "./modules/lambda"` |
| No usar GetX en la app Flutter; el estado se maneja con Bloc (dependencia flutter_bloc en pubspec.yaml) | chequeo estatico (code): exige `flutter_bloc`, `BlocProvider`, `BlocBuilder`; prohibe `getx`, `Get.put`, `Get.find` | Verificada |
| El listado de pedidos soporta pull-to-refresh y las pruebas de aceptacion lo verifican | sin ubicar | Restriccion no verificada en sin ubicar |

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
