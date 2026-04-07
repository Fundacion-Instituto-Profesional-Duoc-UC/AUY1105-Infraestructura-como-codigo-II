output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.mi_ec2.id
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}