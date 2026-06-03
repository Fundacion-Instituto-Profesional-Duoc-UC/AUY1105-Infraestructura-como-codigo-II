output "vpc_id" {
  description = "ID de la VPC desplegada"
  value       = module.networking.vpc_id
}

output "subnet_publica_1_id" {
  description = "ID de la subnet pública 1"
  value       = module.networking.subnet_publica_1_id
}

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = module.compute.instance_id
}

output "instance_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.compute.instance_ip
}

output "bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = module.storage.bucket_name
}