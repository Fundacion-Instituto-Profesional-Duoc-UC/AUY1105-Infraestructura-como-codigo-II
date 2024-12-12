variable "vpc_cidr" {
  description = "CIDR block de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "mi-vpc"
}

variable "subnet_publica_1_cidr" {
  description = "CIDR block de la Subnet pública 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_publica_2_cidr" {
  description = "CIDR block de la Subnet pública 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_privada_1_cidr" {
  description = "CIDR block de la Subnet privada 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "subnet_privada_2_cidr" {
  description = "CIDR block de la Subnet privada 2"
 type        = string
  default     = "10.0.4.0/24"
}

variable "az_1" {
  description = "Zona de disponibilidad para la Subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "az_2" {
  description = "Zona de disponibilidad para la Subnet 2"
  type        = string
  default     = "us-east-1b"
}