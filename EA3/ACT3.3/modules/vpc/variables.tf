variable "cidr_block" {
  description = "CIDR para la VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar hostnames DNS"
  type        = bool
  default     = true
}