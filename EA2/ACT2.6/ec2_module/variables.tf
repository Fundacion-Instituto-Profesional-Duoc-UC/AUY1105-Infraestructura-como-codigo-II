variable "key_name" {
  description = "Nombre del par de claves"
  type        = string
}

variable "public_key" {
  description = "Clave pública SSH"
  type        = string
}

variable "use_security_group" {
  description = "Habilitar o deshabilitar el grupo de seguridad SSH"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "ssh-access"
}

variable "ami" {
  description = "ID de la AMI para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID de la subred donde se creará la instancia"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
  default     = "MiInstancia"
}
