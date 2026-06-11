# --- LLAVES (KEY PAIRS) ---

# Llave 1: La original para la primera instancia
resource "aws_key_pair" "mi_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

# Llave 2: La nueva para las instancias adicionales (Requerimiento)
resource "aws_key_pair" "key_adicional" {
  key_name   = "jboy-2-1"
  public_key = var.public_key_adicional
}

# --- GRUPOS DE SEGURIDAD ---

# SG Público: Solo deja entrar a TU IP (152.230.70.226)
resource "aws_security_group" "sg_publico" {
  name        = "sg_publico_duoc"
  description = "Acceso SSH restringido a la IP del alumno"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH desde mi casa"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mi_ip_publica] # Usará el valor 152.230.70.226/32
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SG Privado: Solo deja entrar si vienes desde una instancia con el SG Público
resource "aws_security_group" "sg_privado" {
  name        = "sg_privado_duoc"
  description = "SSH solo permitido mediante Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH desde instancia publica"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_publico.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- INSTANCIAS ---

# 1. Instancia Pública Original (t2.micro)
resource "aws_instance" "mi_ec2" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mi_key.key_name
  subnet_id              = var.subnet_id_pub_1
  vpc_security_group_ids = [aws_security_group.sg_publico.id]

  tags = { Name = "Instancia-Publica-1" }
}

# 2. Instancia Pública Adicional (t3.micro)
resource "aws_instance" "mi_ec2_pub_2" {
  ami                    = var.ami
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.key_adicional.key_name
  subnet_id              = var.subnet_id_pub_2
  vpc_security_group_ids = [aws_security_group.sg_publico.id]

  tags = { Name = "Instancia-Publica-Extra" }
}

# 3. Instancia Privada (t3.micro)
resource "aws_instance" "mi_ec2_privada" {
  ami                    = var.ami
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.key_adicional.key_name
  subnet_id              = var.subnet_id_privada
  vpc_security_group_ids = [aws_security_group.sg_privado.id]

  tags = { Name = "Instancia-Privada-Lab" }
}