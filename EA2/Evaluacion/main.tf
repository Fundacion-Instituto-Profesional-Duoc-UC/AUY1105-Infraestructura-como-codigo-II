module "networking" {
  source = "github.com/Infra-como-codigo-II-2026/terraform-aws-vpc-auy1105-grupo-6?ref=main"

  vpc_name              = "mi-vpc"
  vpc_cidr              = "10.0.0.0/16"
  subnet_publica_1_cidr = "10.0.1.0/24"
  subnet_publica_2_cidr = "10.0.2.0/24"
  subnet_privada_1_cidr = "10.0.3.0/24"
  subnet_privada_2_cidr = "10.0.4.0/24"
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
  project               = "auy1105"
  environment           = "dev"
}

module "compute" {
  source = "github.com/Infra-como-codigo-II-2026/terraform-aws-ec2-auy1105-grupo-6?ref=main"

  key_name      = var.key_name
  ami           = var.ami
  instance_type = var.instance_type
  instance_name = "MiInstancia"
  subnet_id     = module.networking.subnet_publica_1_id
  vpc_id        = module.networking.vpc_id
  project       = "auy1105"
  environment   = "dev"
}

module "storage" {
  source = "github.com/Infra-como-codigo-II-2026/terraform-aws-s3-auy1105-grupo-6?ref=main"

  bucket_suffix      = "grupo-6-data"
  versioning_enabled = true
  project            = "auy1105"
  environment        = "dev"
}