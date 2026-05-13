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
  value       = aws_security_group.ssh_access.id
}

output "additional_instance_ids" {
  description = "IDs de las instancias adicionales"
  value       = aws_instance.additional_ec2[*].id
}

output "additional_public_ips" {
  description = "IPs públicas de las instancias adicionales"
  value       = aws_instance.additional_ec2[*].public_ip
}

output "additional_private_ips" {
  description = "IPs privadas de las instancias adicionales"
  value       = aws_instance.additional_ec2[*].private_ip
}
