resource "aws_key_pair" "mi_key" {
  key_name   = "mi_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCv/3bh5k1IlpLDCb1sbyxpXCwuOCIVZ/MT7crzUXsuJs6q/76uBox9zVRwj0Kec8lkQ4txNDPGzHFUecozpF11JHIdbt+JOm/feII2z1+JjS7xLbb3vYL7gy/z1OEjQGeUOMxrrtR3MWcWCZmDTCpHHcKcioxMLj1N98yDRp+n10a66CQ28qU9LwF66mb5g65MunoZ6LJWie/6CTolIBmyvs00oj/t3UZR8MPEgL2O++r176eNURqzt8JZ8GNXkVr9NqOztF4B2qK17HZQryu8wpoeXZeODDtUaksEY+pIeb2m4QAA7Y0WfuCJY2C5NP3kK+HxhiE0IYVOaT7HAB8l"
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