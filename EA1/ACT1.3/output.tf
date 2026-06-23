output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ec2_instance.id
}