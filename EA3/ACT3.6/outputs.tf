output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.web.id
}

output "volume_id" {
  description = "ID del volumen EBS"
  value       = aws_ebs_volume.data.id
}
