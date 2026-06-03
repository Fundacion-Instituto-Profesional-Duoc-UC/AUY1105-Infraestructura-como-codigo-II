variable "instance_type" {
  description = "Tipo de instancia para la EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del par de claves SSH registrado en AWS"
  type        = string
  default     = "vockey"
}

variable "ami" {
  description = "ID de la AMI para la instancia EC2"
  type        = string
  default     = "ami-0ec10929233384c7f"
}