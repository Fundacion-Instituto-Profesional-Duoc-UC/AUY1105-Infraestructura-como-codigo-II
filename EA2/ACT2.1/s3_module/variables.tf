variable "bucket_prefix" {
  description = "Prefijo para el nombre del bucket"
  type        = string
}

variable "bucket_suffix" {
  description = "Sufijo para el nombre del bucket"
  type        = string
}

variable "tags" {
  description = "Etiquetas para el recurso"
  type        = map(string)
  default     = {}
}