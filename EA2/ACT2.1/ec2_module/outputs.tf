output "instance_id" {
  # Cambiado de mi_ec2 a publica o publica_1 según tu main.tf
  value = aws_instance.publica.id 
}

output "public_ip" {
  value = aws_instance.publica.public_ip
}

output "security_group_id" {
  # Cambiado de ssh_access a sg_pub
  value = aws_security_group.sg_pub.id
}
