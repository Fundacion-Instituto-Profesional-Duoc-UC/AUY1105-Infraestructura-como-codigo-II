resource "aws_key_pair" "mi_key" {
  key_name   = "mi_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Permitir acceso SSH desde IP especifica"
  vpc_id      = aws_vpc.mi_vpc.id

  ingress {
    description = "SSH desde una IP conocida"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # CKV_AWS_24: Se usa una IP simulada para evitar el 0.0.0.0/0
    cidr_blocks = ["203.0.113.50/32"] 
  }

  egress {
    description = "Permitir trafico de salida controlado"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # CKV_AWS_382: Limitado a la red interna para mayor seguridad
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "ssh-access"
  }
}

resource "aws_instance" "mi_ec2" {
  ami                    = "ami-012967cc5a8c9f891"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mi_key.key_name
  subnet_id              = aws_subnet.subnet_publica_1.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  # CKV2_AWS_41: Asociar el perfil de instancia IAM (Rol de seguridad)
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  # CKV_AWS_126: Monitoreo detallado habilitado
  monitoring = true

  # CKV_AWS_135: Optimizado para EBS
  ebs_optimized = true

  # CKV_AWS_79: Forzar IMDSv2 para proteger metadatos
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "MiInstancia"
  }

  root_block_device {    
    # CKV_AWS_8: Cifrado de disco habilitado
    encrypted   = true
  }
}