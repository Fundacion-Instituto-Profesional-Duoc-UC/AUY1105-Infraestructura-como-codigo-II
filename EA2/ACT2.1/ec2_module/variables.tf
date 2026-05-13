variable "key_name" {
  description = "Nombre del par de claves"
  type        = string
}

variable "public_key" {
  description = "Clave pública SSH"
  type        = string
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

# Nuevas variables para instancias adicionales
variable "additional_instances" {
  description = "Lista de configuraciones para instancias adicionales"
  type = list(object({
    instance_name   = string
    instance_type   = string
    subnet_id       = string
    security_group_name = string
    allow_ssh_from  = string  # CIDR o IP para SSH
  }))
  default = []
}

variable "new_key_name" {
  description = "Nombre del nuevo par de claves para instancias adicionales"
  type        = string
  default     = "terraform_key"
}

variable "new_public_key" {
  description = "Nueva clave pública SSH para instancias adicionales (opcional)"
  type        = string
  default     = ""
}
