terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # <--- Cambia el 5.0 por 6.0
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- MÓDULO DE RED (VPC) ---
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

# --- MÓDULO DE COMPUTO (EC2) ---
module "ec2" {
  source               = "./ec2_module"
  ami                  = "ami-012967cc5a8c9f891"
  vpc_id               = module.vpc.vpc_id
  instance_name        = "MiInstancia"

  # Tu IP pública para acceso seguro 
  mi_ip_publica        = "152.230.70.226/32"

  # Conexión con los IDs de las subredes (Outputs de tu VPC) 
  subnet_id_pub_1      = module.vpc.subnet_publica_1_id
  subnet_id_pub_2      = module.vpc.subnet_publica_2_id
  subnet_id_privada    = module.vpc.subnet_privada_id

  # 1. LLAVE ORIGINAL (La que tenías al principio)
  key_name             = "mi_key_name"
  public_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"

  # 2. NUEVA LLAVE (La que generaste recién con ssh-keygen)
  public_key_adicional = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxrRqRug5mdFuiGEl9ovz/UwDcuA/CriuqV1tfUK/OtyA/f/eOLOK38fDAC208GJhFdIJakS2Cjfwgb+DDmWBBvclEY49qXXhdF13J89zx+9I1vRQ92LsR7epe3yZJHHthcRzV+S/sTNoLAcJs/Uyej07Co1MqWJqPYYGGGW1jXyTxluZuAl7xwljZlNgHVotNYDduSiUWeMrZ7+qhSk2NHtB3uzI3qJgfCXoM4PAe+sNdCs48TZXxEPjrRi7hyZd0LeWwPnGxt+v2DHEwiWo5SbRqgmBi73QEwUg4OiGVmCGM2BfF1vdH9JCllIUH6UQOTs+jlqWV4AkRgde6l+gf duocacad\\ma-alumno@MAAWSA02LC1013"
}

# --- NUEVO MÓDULO S3 ---
module "s3_proyecto" {
  source        = "./s3_module"
  
  bucket_prefix = "ignacio"
  bucket_suffix = "lab-infra-2026"

  tags = {
    Environment = "Dev"
    Project     = "TechNova"
  }
}