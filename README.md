# Infraestructura como Código II - Evaluación Parcial 1

## Propósito General
Este repositorio contiene la implementación de un pipeline automatizado mediante GitHub Actions, integrando herramientas de análisis de calidad (TFLint), seguridad (Checkov) y despliegue de infraestructura en AWS mediante Terraform.

## Objetivos
- Desplegar una arquitectura de red (VPC, Subnets, Security Groups) y cómputo (EC2 Ubuntu) en AWS.
- Validar la calidad y seguridad del código de infraestructura de manera automatizada.
- Aplicar políticas de seguridad restrictivas utilizando Open Policy Agent (OPA).
- Trabajar de forma colaborativa mediante revisiones de código (Pull Requests).

## Instrucciones de Uso
1. Clonar el repositorio.
2. Posicionarse en el directorio raíz.
3. Ejecutar `terraform init` para inicializar el entorno.
4. Ejecutar `terraform plan` para visualizar los recursos a desplegar.
5. Ejecutar `terraform apply` para provisionar la infraestructura en AWS.

## Definición del Código Terraform
El código base despliega los siguientes recursos en la nube de AWS:
- **Redes:** VPC con bloque CIDR 10.1.0.0/16 y Subred Pública.
- **Seguridad:** Security Group con reglas de ingreso estrictas.
- **Cómputo:** Instancia EC2 (t2.micro) con sistema operativo Ubuntu 24.04 LTS.
