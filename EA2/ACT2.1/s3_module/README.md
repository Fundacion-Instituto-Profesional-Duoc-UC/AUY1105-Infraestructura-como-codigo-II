# Módulo S3 para Terraform

Este módulo crea un bucket S3 en AWS con configuraciones básicas como versioning, bloqueo de acceso público y una política opcional de lectura pública. Está diseñado para ser reutilizable y configurable mediante variables.

## Paso a Paso: Cómo Crear Este Módulo

Sigue estos pasos para crear el módulo S3 desde cero. Esto te ayudará a entender la estructura de un módulo Terraform.

### 1. Crear la Estructura de Directorios

Primero, crea un directorio para el módulo. Por ejemplo, dentro de tu proyecto Terraform:

```bash
mkdir s3_module
cd s3_module
```

### 2. Crear el Archivo `variables.tf`

Este archivo define las variables de entrada del módulo. Crea `variables.tf` con el siguiente contenido:

```hcl
variable "bucket_prefix" {
  description = "Prefijo para el nombre del bucket S3"
  type        = string
}

variable "bucket_suffix" {
  description = "Sufijo para el nombre del bucket S3"
  type        = string
}

variable "versioning_enabled" {
  description = "Habilitar versioning en el bucket S3"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Bloquear ACLs públicas en el bucket"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Bloquear políticas públicas en el bucket"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Ignorar ACLs públicas en el bucket"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Restringir buckets públicos"
  type        = bool
  default     = false
}

variable "enable_public_policy" {
  description = "Habilitar política pública de lectura en el bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags adicionales para el bucket S3"
  type        = map(string)
  default     = {}
}
```

### 3. Crear el Archivo `main.tf`

Este es el archivo principal que define los recursos. Crea `main.tf` con el siguiente contenido:

```hcl
resource "aws_s3_bucket" "mi_bucket" {
  bucket = "${var.bucket_prefix}-${var.bucket_suffix}"

  tags = merge({
    Name = "${var.bucket_prefix}-${var.bucket_suffix}"
  }, var.tags)
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mi_bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mi_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "public_read" {
  count = var.enable_public_policy ? 1 : 0

  bucket = aws_s3_bucket.mi_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.mi_bucket.arn}/*"
      }
    ]
  })
}
```

### 4. Crear el Archivo `outputs.tf`

Este archivo define las salidas del módulo. Crea `outputs.tf` con el siguiente contenido:

```hcl
output "bucket_id" {
  description = "ID del bucket S3"
  value       = aws_s3_bucket.mi_bucket.id
}

output "bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = aws_s3_bucket.mi_bucket.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.mi_bucket.arn
}
```

### 5. Crear el Archivo `README.md`

¡Este es el archivo que estás leyendo! Copia el contenido de arriba a un archivo llamado `README.md`.

## Cómo Usar el Módulo

En tu archivo principal de Terraform (ej. `main.tf` en el root), incluye el módulo así:

```hcl
module "s3" {
  source = "./s3_module"

  bucket_prefix = "mi-proyecto"
  bucket_suffix = "dev"
  tags = {
    Environment = "development"
  }
}

# Acceder a las salidas
output "s3_bucket_name" {
  value = module.s3.bucket_name
}
```

## Variables

| Nombre | Descripción | Tipo | Default |
|--------|-------------|------|---------|
| bucket_prefix | Prefijo para el nombre del bucket | string | - |
| bucket_suffix | Sufijo para el nombre del bucket | string | - |
| versioning_enabled | Habilitar versioning | bool | true |
| block_public_acls | Bloquear ACLs públicas | bool | false |
| block_public_policy | Bloquear políticas públicas | bool | false |
| ignore_public_acls | Ignorar ACLs públicas | bool | false |
| restrict_public_buckets | Restringir buckets públicos | bool | false |
| enable_public_policy | Habilitar política pública | bool | true |
| tags | Tags adicionales | map(string) | {} |

## Outputs

| Nombre | Descripción |
|--------|-------------|
| bucket_id | ID del bucket S3 |
| bucket_name | Nombre del bucket S3 |
| bucket_arn | ARN del bucket S3 |

## Notas

- Asegúrate de tener configurado tu provider AWS en el archivo principal.
- El bucket se crea con una política pública por defecto; ajusta las variables según tus necesidades de seguridad.
- Para más información sobre S3, consulta la [documentación de AWS](https://docs.aws.amazon.com/s3/).

¡Felicidades! Has creado tu primer módulo Terraform reutilizable.