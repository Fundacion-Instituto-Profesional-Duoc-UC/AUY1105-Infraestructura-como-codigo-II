output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}

output "subnet_publica_1_id" {
  description = "ID de la primera subred publica"
  value       = aws_subnet.subnet_publica_1.id
}

output "subnet_publica_2_id" {
  description = "ID de la segunda subred publica"
  value       = aws_subnet.subnet_publica_2.id
}

output "subnet_privada_id" {
  description = "ID de la subred privada (usaremos la 1 para la EC2)"
  value       = aws_subnet.subnet_privada_1.id
}
