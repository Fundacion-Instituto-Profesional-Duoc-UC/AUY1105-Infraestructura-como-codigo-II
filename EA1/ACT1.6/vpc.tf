resource "aws_vpc" "mi_vpc" {
   cidr_block           = "10.0.0.0/16"
   enable_dns_support   = true
   enable_dns_hostnames = true
   
   # EXCEPCION CHECKOV
   # checkov:skip=CKV2_AWS_11: Flow Logs omitidos para simplificar el entorno educativo.
   
   tags = {
     Name = "mi-vpc"
   }
}

# Bloqueo del SG por defecto
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mi_vpc.id
}

resource "aws_subnet" "subnet_publica_1" {
   vpc_id                  = aws_vpc.mi_vpc.id
   cidr_block              = "10.0.1.0/24"
   availability_zone       = "us-east-1a"
   map_public_ip_on_launch = true

   # EXCEPCION CHECKOV
   # checkov:skip=CKV_AWS_130: Se requiere asignar IP publica para acceder al laboratorio.

   tags = {
     Name = "subnet-publica-1"
   }
}

resource "aws_subnet" "subnet_publica_2" {
   vpc_id                  = aws_vpc.mi_vpc.id
   cidr_block              = "10.0.2.0/24"
   availability_zone       = "us-east-1b"
   map_public_ip_on_launch = true

   # EXCEPCION CHECKOV
   # checkov:skip=CKV_AWS_130: Se requiere asignar IP publica para acceder al laboratorio.

   tags = {
     Name = "subnet-publica-2"
   }
}