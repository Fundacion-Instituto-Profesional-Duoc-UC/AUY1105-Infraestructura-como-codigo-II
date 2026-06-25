terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # O la versión que estés usando
    }
  }
}

provider "aws" {
  region = "us-east-1" # <--- O la región que prefieras (us-east-2, us-west-2, etc.)
}

module "vpc" {
  source                = "./vpc_module"
  vpc_cidr              = "10.1.0.0/16"
  vpc_name              = "mi-vpc-principal"
  subnet_publica_1_cidr = "10.1.1.0/24"
  subnet_publica_2_cidr = "10.1.2.0/24"
  subnet_privada_1_cidr = "10.1.3.0/24"
  subnet_privada_2_cidr = "10.1.4.0/24"
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = "./ec2_module"
  key_name      = "mi_key_name"
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = "MiInstancia"
  
  # Si tienes la variable para la subred privada definida, pásala también:
  subnet_privada_1_id = module.vpc.subnet_privada_1_id
  subnet_publica_2_id = module.vpc.subnet_publica_2_id
}

module "s3" {
  source                  = "./s3_module"
  bucket_prefix           = "lab-infra"
  bucket_suffix           = "estudiante-12345"
  versioning_enabled      = true
  enable_public_policy    = true # Cambia a false si el laboratorio te da error de permisos
  block_public_acls       = false
  block_public_policy     = false # Debe ser false para que la política de lectura pública funcione
  ignore_public_acls      = false
  restrict_public_buckets = false

  tags = {
    Proyecto = "Laboratorio-Terraform"
  }
}
