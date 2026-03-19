# Crear la VPC
resource "aws_vpc" "mi_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "mi-vpc"
  }
}

# Crear un Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "mi-igw"
  }
}

# Crear subnets públicas
resource "aws_subnet" "subnet_publica_1" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-publica-1"
  }
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-publica-2"
  }
}

# Crear subnets privadas
resource "aws_subnet" "subnet_privada_1" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-privada-1"
  }
}

resource "aws_subnet" "subnet_privada_2" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-privada-2"
  }
}

# Crear un NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
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

# Tabla de enrutamiento pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "public-rt"
  }
}

# Asociar subnets públicas a la tabla pública
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.subnet_publica_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.subnet_publica_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Crear ruta para Internet en la tabla pública
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Tabla de enrutamiento privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = {
    Name = "private-rt"
  }
}

# Asociar subnets privadas a la tabla privada
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.subnet_privada_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.subnet_privada_2.id
  route_table_id = aws_route_table.private_rt.id
}

# Crear ruta para NAT en la tabla privada
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
