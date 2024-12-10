resource "aws_key_pair" "mi_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "ssh_access" {
  count       = var.use_security_group ? 1 : 0 # Condicional basado en la variable
  name        = var.security_group_name
  description = "Permitir acceso SSH desde cualquier IPv4"
  vpc_id      = var.vpc_id

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
    Name = var.security_group_name
  }
}

resource "aws_instance" "mi_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.mi_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.use_security_group ? [aws_security_group.ssh_access[0].id] : []

  tags = {
    Name = var.instance_name
  }
}