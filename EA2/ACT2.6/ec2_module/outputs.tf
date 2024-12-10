output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.mi_ec2.id
}

output "public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.mi_ec2.public_ip
}

output "security_group_id" {
  description = "ID del grupo de seguridad"
  value       = length(aws_security_group.ssh_access) > 0 ? aws_security_group.ssh_access[0].id : null
}
