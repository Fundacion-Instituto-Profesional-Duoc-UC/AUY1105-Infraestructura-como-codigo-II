resource "aws_key_pair" "mi_key" {
  key_name   = "mi_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtIIzTGDq4IhZcFwNhuVAmmio9Il/EXtNmwgqeshRvOYwAR7Wh2xBPxMisGg24oekcBbmC4J7g5JHsdkQZ2XHH5wpTy+YAGcjYY1yRy/RUCu/HCR4s1Q6bKyWiIbKJoVW1M0QV0e7CGse46aqOUrettouxa6MWR8Mt2rJG8IyMQTkyiceVEyByzkjdHn8neskm5FUjq3L1hHfJga0f1yk47KMfkbmZpeLZsxaDfRDvtojdfWW0zlpWiyafk7Fj2j1CCAwbFvmTW3eHc/C0In/tWOsFDARcZfZsGFAtmaYrtwZK7iWkoIO29hhPAAzBMXCKHmoCoMAT6CPJGmOZH3SP cjerez"
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Permitir acceso SSH desde cualquier IPv4"
  vpc_id      = aws_vpc.mi_vpc.id

  ingress {
    description = "SSH desde cualquier lugar"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir desde cualquier dirección IPv4
  }

  egress {
    description = "Permitir trafico de salida a cualquier lugar"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-access"
  }
}

resource "aws_instance" "mi_ec2" {
  ami                         = "ami-012967cc5a8c9f891"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.mi_key.key_name
  subnet_id                   = aws_subnet.subnet_publica_1.id
  vpc_security_group_ids      = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true

  tags = {
    Name = "MiInstancia"
  }
}