module "vpc" {
  source                = "github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II//EA2/ACT2.5/vpc_module?ref=v1.0.0"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  subnet_publica_1_cidr = var.subnet_publica_1_cidr
  subnet_publica_2_cidr = var.subnet_publica_2_cidr
  subnet_privada_1_cidr = var.subnet_privada_1_cidr
  subnet_privada_2_cidr = var.subnet_privada_2_cidr
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = "github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II//EA2/ACT2.5/ec2_module?ref=v1.0.0"
  key_name      = var.key_name
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = var.instance_name
}


