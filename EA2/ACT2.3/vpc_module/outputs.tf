output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}

output "subnet_publica_1_id" {
  description = "ID de la Subnet pública 1"
  value       = aws_subnet.subnet_publica_1.id
}

output "subnet_publica_2_id" {
  description = "ID de la Subnet pública 2"
  value       = aws_subnet.subnet_publica_2.id
}

output "subnet_privada_1_id" {
  description = "ID de la Subnet privada 1"
  value       = aws_subnet.subnet_privada_1.id
}

output "subnet_privada_2_id" {
  description = "ID de la Subnet privada 2"
  value       = aws_subnet.subnet_privada_2.id
}
