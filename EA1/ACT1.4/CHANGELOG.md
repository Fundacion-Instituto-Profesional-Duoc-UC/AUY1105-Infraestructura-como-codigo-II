# Changelog

Este archivo contiene los cambios realizados en el proyecto de infraestructura como código utilizando Terraform. Sigue el formato [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) y respeta la semántica de versiones [Semantic Versioning](https://semver.org/lang/es/).

## [Unreleased]
### Agregado
- Definición inicial de variables en `variables.tf`.
- Documentación generada automáticamente con `terraform-docs`.
- Configuración básica de `provider` para AWS.

## [1.0.1] - 2024-11-28
### Corregido
- Solucionado un error en el nombre de salida `instance_id` en `output.tf`.
- Actualizadas las reglas de seguridad en `main.tf` para permitir solo tráfico SSH (puerto 22).

### Agregado
- Inclusión de la variable `instance_type` en `variables.tf` con valor por defecto `t2.micro`.
- Nueva salida `public_ip` para mostrar la dirección IP pública de la instancia EC2.

### Cambiado
- Actualización del nombre del bucket S3 a un nombre único generado dinámicamente.
- Modificación de `main.tf` para usar `aws_instance` con una AMI diferente.

## [1.0.0] - 2024-11-20
### Agregado
- Configuración inicial del proyecto con soporte para AWS.
- Creación de la instancia EC2 básica con `t2.micro`.
- Configuración del almacenamiento local y volumen EBS.
- Implementación de variables y outputs básicos para identificar recursos creados.

---

**Nota:** Este archivo se mantendrá actualizado con cada cambio significativo para mejorar la trazabilidad y la colaboración.