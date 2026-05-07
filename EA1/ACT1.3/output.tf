output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.mi_ec2.id
}
