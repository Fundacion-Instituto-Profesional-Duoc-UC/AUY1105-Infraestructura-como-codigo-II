module "vpc" {
  source                = "./vpc_module"
  vpc_cidr              = "10.1.0.0/16"
  vpc_name              = "mi-vpc-principal"
  subnet_publica_1_cidr = "10.1.1.0/24"
  subnet_publica_2_cidr = "10.1.2.0/24"
  subnet_privada_1_cidr = "10.1.3.0/24"
  subnet_privada_2_cidr = "10.1.4.0/24"
  subnet_publica_3_cidr = "10.1.5.0/24"
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = "./ec2_module"
  key_name      = "mi_key_name"
  public_key    = file("/home/ec2-user/.ssh/id_rsa.pub")
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = "MiInstancia"

  security_group_name = "lucia-sg"
}

module "s3" {
  source        = "./s3_module"
  bucket_prefix = "lucia-act21"
  bucket_suffix = "bucket-2026"
}

