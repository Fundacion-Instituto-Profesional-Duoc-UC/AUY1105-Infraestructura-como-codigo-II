variable "key_name" {
  description = "Nombre del par de claves original"
  type        = string
}

variable "public_key" {
  description = "Clave pública SSH original"
  type        = string
}

# --- NUEVAS VARIABLES PARA EL REQUERIMIENTO ---

variable "public_key_adicional" {
  description = "Clave pública para las nuevas instancias"
  type        = string
}

variable "mi_ip_publica" {
  description = "Tu IP pública para restringir el acceso SSH (ej: 186.10.20.30/32)"
  type        = string
}

variable "subnet_id_pub_1" {
  description = "ID de la primera subred pública"
  type        = string
}

variable "subnet_id_pub_2" {
  description = "ID de la segunda subred pública"
  type        = string
}

variable "subnet_id_privada" {
  description = "ID de la subred privada"
  type        = string
}

# --- VARIABLES GENERALES ---

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "ami" {
  description = "ID de la AMI para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 por defecto"
  type        = string
  default     = "t2.micro"
}

variable "security_group_name" {
  description = "Nombre base para los grupos de seguridad"
  type        = string
  default     = "ssh-access"
}

variable "instance_name" {
  description = "Nombre base de la instancia"
  type        = string
  default     = "MiInstancia"
}