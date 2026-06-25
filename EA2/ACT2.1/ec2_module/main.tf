resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key # Sin la función file()
}

# 2. Security Group Público (Bastión / Salto)
resource "aws_security_group" "sg_pub" {
  name        = "sg_acceso_publico"
  description = "Permitir SSH desde internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH desde cualquier lugar"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # En producción, usa tu IP real
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "SG-Publico" }
}

# 3. Security Group Privado (Acceso restringido)
resource "aws_security_group" "sg_priv" {
  name        = "sg_acceso_privado"
  description = "Solo permite SSH desde el SG Publico"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH interno"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_pub.id] # Referencia al SG público
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "SG-Privado" }
}

# 4. Instancia Pública (Bastion Host)
resource "aws_instance" "publica" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name # Referencia corregida
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sg_pub.id]

  tags = { Name = "Instancia-Publica" }
}

# 5. Instancia Privada
resource "aws_instance" "privada" {
  ami                    = var.ami
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = var.subnet_privada_1_id
  vpc_security_group_ids = [aws_security_group.sg_priv.id]

  tags = { Name = "Instancia-Privada" }
}
