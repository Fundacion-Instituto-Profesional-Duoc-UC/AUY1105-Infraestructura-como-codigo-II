output "vpc_id" {
  description = "El ID de la VPC creada en el módulo"
  value       = aws_vpc.main.id
}