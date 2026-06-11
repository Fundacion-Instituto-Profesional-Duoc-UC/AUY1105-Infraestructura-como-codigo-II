output "instancia_publica_1_ip" {
  description = "IP publica de la primera instancia"
  value       = aws_instance.mi_ec2.public_ip
}

output "instancia_publica_2_ip" {
  description = "IP publica de la instancia extra"
  value       = aws_instance.mi_ec2_pub_2.public_ip
}

output "instancia_privada_ip" {
  description = "IP privada de la instancia en subred privada"
  value       = aws_instance.mi_ec2_privada.private_ip
}

# Aquí estaba el error, ahora apunta a 'sg_publico'
output "security_group_publico_id" {
  description = "ID del Security Group publico"
  value       = aws_security_group.sg_publico.id
}

output "security_group_privado_id" {
  description = "ID del Security Group privado"
  value       = aws_security_group.sg_privado.id
}