variable "key_name" {
  description = "Nombre de la llave SSH"
  type        = string
  default     = "mi-llave"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
  default     = "mi-instancia"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "mi-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_publica_1_cidr" {
  description = "CIDR block para la Subnet Pública 1"
  type        = string
  default     = "10.1.1.0/24"
}

variable "subnet_publica_2_cidr" {
  description = "CIDR block para la Subnet Pública 2"
  type        = string
  default     = "10.1.2.0/24"
}

variable "subnet_privada_1_cidr" {
  description = "CIDR block para la Subnet Privada 1"
  type        = string
  default     = "10.1.3.0/24"
}

variable "subnet_privada_2_cidr" {
  description = "CIDR block para la Subnet Privada 2"
  type        = string
  default     = "10.1.4.0/24"
}