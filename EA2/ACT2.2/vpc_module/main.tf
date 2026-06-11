resource "aws_vpc" "mi_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "mi-igw"
  }
}

# --- SUBREDES PÚBLICAS ---

resource "aws_subnet" "subnet_publica_1" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.subnet_publica_1_cidr
  availability_zone       = var.az_1
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-publica-1"
  }
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.subnet_publica_2_cidr
  availability_zone       = var.az_2
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-publica-2"
  }
}

# REQUERIMIENTO: Tercera subred pública (10.1.5.0/24)
resource "aws_subnet" "subnet_publica_3" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.subnet_publica_3_cidr
  availability_zone       = var.az_1 # La asignamos a la primera AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-publica-3"
  }
}

# --- SUBREDES PRIVADAS ---

resource "aws_subnet" "subnet_privada_1" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.subnet_privada_1_cidr
  availability_zone = var.az_1
  tags = {
    Name = "subnet-privada-1"
  }
}

resource "aws_subnet" "subnet_privada_2" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.subnet_privada_2_cidr
  availability_zone = var.az_2
  tags = {
    Name = "subnet-privada-2"
  }
}

# --- CONECTIVIDAD (NAT Gateway) ---

resource "aws_eip" "nat_eip" {
  domain = "vpc" # Formato actualizado para 2026
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_publica_1.id
  tags = {
    Name = "nat-gw"
  }
}

# --- TABLAS DE RUTAS ---

# Pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Asociaciones Públicas
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.subnet_publica_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.subnet_publica_2.id
  route_table_id = aws_route_table.public_rt.id
}

# REQUERIMIENTO: Asociación de la tercera subred pública
resource "aws_route_table_association" "public_assoc_3" {
  subnet_id      = aws_subnet.subnet_publica_3.id
  route_table_id = aws_route_table.public_rt.id
}

# Privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.subnet_privada_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.subnet_privada_2.id
  route_table_id = aws_route_table.private_rt.id
}