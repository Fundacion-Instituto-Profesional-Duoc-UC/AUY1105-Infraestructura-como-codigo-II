locals {
  common_tags = {
    Environment = var.environment
    Project     = "Actividad-3.3"
  }
}

# 1. Llamando al módulo VPC
module "mi_vpc" {
  source               = "./modules/vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# 2. Grupo de seguridad asociado a la VPC creada
resource "aws_security_group" "ejemplo" {
  name        = "sg_reglas_multiples"
  description = "SG de ejemplo iterando con for_each"
  vpc_id      = module.mi_vpc.vpc_id
  tags        = local.common_tags
}

# 3. Creación de reglas dinámicas con for_each (puertos 22 y 80)
resource "aws_security_group_rule" "allow_ports" {
  for_each = toset(["22", "80"])

  type              = "ingress"
  from_port         = tonumber(each.key)
  to_port           = tonumber(each.key)
  protocol          = "tcp"
  security_group_id = aws_security_group.ejemplo.id
  cidr_blocks       = ["0.0.0.0/0"]
}