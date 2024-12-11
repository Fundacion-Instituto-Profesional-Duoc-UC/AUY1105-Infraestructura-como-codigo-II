# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# REVISIÓN DE CÓDIGO MEDIANTE PULL REQUEST

## DESARROLLO DE ACTIVIDAD

### 1. Realizar un Fork del Repositorio

1. Accede al repositorio de GitHub proporcionado: [AUY1105-Infraestructura-como-codigo-II](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II).  
2. Haz clic en el botón **Fork** en la parte superior derecha de la página.  
3. Selecciona tu cuenta de GitHub como destino del fork.

Para más detalles sobre cómo hacer un fork, consulta la guía oficial de GitHub:  
[GitHub Docs: Fork a Repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

### 2. Clonar el Repositorio Forkeado en Tu Máquina Local

Ejecuta el siguiente comando en tu terminal para clonar tu fork:

```bash
git clone https://github.com/tu-usuario/AUY1105-Infraestructura-como-codigo-II.git
```

### 3. Revisar el Código y Realizar un Cambio Pequeño

- Navega al directorio del proyecto:
```bash
cd AUY1105-Infraestructura-como-codigo-II
```
- Abre el proyecto en tu editor de código preferido (por ejemplo, VS Code):
```bash
code .
```
- Realiza un cambio pequeño, como corregir un comentario, actualizar documentación o modificar una línea de código simple. Por ejemplo, en el archivo **provider.tf** podrías mejorar la manera en la que se declara el provider:

**ANTES**

```bash
provider "aws" {
  region = "us-east-1"
}
```

**DESPUÉS**
```bash
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

- Guarda los cambios y ejecuta los siguientes comandos para hacer commit y subir los cambios:
```bash
git add .
git commit -m "Pequeño cambio sugerido"
git push origin main
```
### 4. Crear un Pull Request

- Accede a tu repositorio forkeado en GitHub.
- Haz clic en el botón Compare & pull request.
- Escribe un mensaje claro describiendo los cambios realizados y por qué son útiles.
- Haz clic en Create pull request.

[GitHub Docs: Create a Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).

## TRABAJO AUTÓNOMO

Analiza el resto de los archivos, y observa si existen cambios que consideres se deban realizar. Realiza los cambios en tu repositorio, y genera una propuesta de tus cambios mediante un **pull request** al repositorio de la clase.

## REFLEXIONES

- **Fomento de buenas prácticas y estándares:** Revisar código mediante pull requests no solo asegura que las configuraciones cumplan con los estándares de calidad, sino que también promueve un enfoque estructurado para identificar problemas de seguridad y eficiencia en el uso de Terraform para AWS.

- **Desarrollo de habilidades colaborativas**:** Esta práctica resalta la importancia del trabajo en equipo y el uso efectivo de herramientas como GitHub para mejorar la infraestructura como código, facilitando un entorno de aprendizaje compartido.

- **Preparación para entornos profesionales:** Al simular escenarios reales de revisión de código, los estudiantes se preparan para enfrentar desafíos en proyectos del mundo laboral, donde la revisión minuciosa y las sugerencias constructivas son clave para la implementación exitosa de sistemas complejos.