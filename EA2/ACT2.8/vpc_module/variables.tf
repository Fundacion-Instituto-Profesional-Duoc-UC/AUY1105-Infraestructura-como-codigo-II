variable "vpc_cidr" {
  description = "CIDR block de la VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "subnet_publica_1_cidr" {
  description = "CIDR block de la Subnet pública 1"
  type        = string
}

variable "subnet_publica_2_cidr" {
  description = "CIDR block de la Subnet pública 2"
  type        = string
}

variable "subnet_privada_1_cidr" {
  description = "CIDR block de la Subnet privada 1"
  type        = string
}

variable "subnet_privada_2_cidr" {
  description = "CIDR block de la Subnet privada 2"
  type        = string
}

variable "az_1" {
  description = "Zona de disponibilidad para la Subnet 1"
  type        = string
}

variable "az_2" {
  description = "Zona de disponibilidad para la Subnet 2"
  type        = string
}