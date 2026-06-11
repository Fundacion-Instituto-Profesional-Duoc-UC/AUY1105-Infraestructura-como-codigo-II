variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}