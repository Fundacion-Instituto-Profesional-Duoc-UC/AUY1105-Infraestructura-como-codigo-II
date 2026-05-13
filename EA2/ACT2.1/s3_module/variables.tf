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