variable "region" {
  description = "Región de AWS a usar"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Zona de disponibilidad para los volúmenes EBS"
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "AMI a utilizar para la instancia EC2"
  type        = string
  default     = "ami-012967cc5a8c9f891"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "volume_size" {
  description = "Tamaño del volumen EBS en GB"
  type        = number
  default     = 10
}