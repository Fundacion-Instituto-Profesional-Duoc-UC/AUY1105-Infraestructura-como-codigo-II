resource "aws_key_pair" "mi_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_key_pair" "new_key" {
  count      = var.new_public_key != "" ? 1 : 0
  key_name   = var.new_key_name
  public_key = var.new_public_key
}

resource "aws_security_group" "ssh_access" {
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
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = var.instance_name
  }
}

# Security groups para instancias adicionales
resource "aws_security_group" "additional_sg" {
  count       = length(var.additional_instances)
  name        = var.additional_instances[count.index].security_group_name
  description = "Security group for additional instance"
  vpc_id      = var.vpc_id

  egress {
    description = "Permitir trafico de salida a cualquier lugar"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.additional_instances[count.index].security_group_name
  }
}

resource "aws_security_group_rule" "additional_ingress" {
  count = length(var.additional_instances)

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.additional_sg[count.index].id

  # For the first additional instance (public), allow from user IP
  # For the second (private), allow from the private IP of the first additional instance
  cidr_blocks = count.index == 0 ? [var.additional_instances[count.index].allow_ssh_from] : ["${aws_instance.additional_ec2[0].private_ip}/32"]
}

resource "aws_instance" "additional_ec2" {
  count         = length(var.additional_instances)
  ami           = var.ami
  instance_type = var.additional_instances[count.index].instance_type
  key_name      = var.new_public_key != "" ? aws_key_pair.new_key[0].key_name : aws_key_pair.mi_key.key_name
  subnet_id     = var.additional_instances[count.index].subnet_id
  vpc_security_group_ids = [aws_security_group.additional_sg[count.index].id]

  tags = {
    Name = var.additional_instances[count.index].instance_name
  }
}