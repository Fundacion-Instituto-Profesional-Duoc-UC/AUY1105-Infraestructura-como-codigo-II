resource "aws_key_pair" "mi_key" {
  key_name   = "mi_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Permitir acceso SSH desde cualquier IPv4"
  vpc_id      = aws_vpc.mi_vpc.id

  # EXCEPCIONES PARA CHECKOV (Justificadas para laboratorio)
  # checkov:skip=CKV_AWS_24: Se mantiene el puerto 22 abierto para facilitar el acceso en el entorno educativo.
  # checkov:skip=CKV_AWS_382: Se permite la salida a internet irrestricta por requerimientos del laboratorio.

  ingress {
    description = "SSH desde cualquier lugar"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    description = "Permitir trafico de salida a cualquier lugar"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
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

  # SOLUCIÓN CKV_AWS_126: Habilitar monitoreo detallado
  monitoring = true

  # SOLUCIÓN CKV_AWS_79: Requerir la versión 2 de Metadatos (IMDSv2 por seguridad)
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {    
    encrypted = true
  }

  # EXCEPCIONES PARA CHECKOV (Limitaciones técnicas de tu laboratorio)
  # checkov:skip=CKV_AWS_135: El tipo de instancia t2.micro no soporta optimización EBS.
  # checkov:skip=CKV2_AWS_41: No se requiere asignar un IAM role para esta actividad.

  tags = {
    Name = "MiInstancia"
  }
}