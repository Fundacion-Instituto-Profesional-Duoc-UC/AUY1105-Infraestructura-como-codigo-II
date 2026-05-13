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

variable "security_group_name" {
  description = "Nombre del grupo de seguridad para la instancia EC2"
  type        = string
  default     = "mi-instancia-ssh"
}

variable "ec2_instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}