variable "key_name" {
  description = "Nombre de la llave SSH"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "subnet_publica_1_cidr" {
  description = "CIDR block para la Subnet Pública 1"
  type        = string
}

variable "subnet_publica_2_cidr" {
  description = "CIDR block para la Subnet Pública 2"
  type        = string
}

variable "subnet_privada_1_cidr" {
  description = "CIDR block para la Subnet Privada 1"
  type        = string
}

variable "subnet_privada_2_cidr" {
  description = "CIDR block para la Subnet Privada 2"
  type        = string
}