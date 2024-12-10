output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "subnet_publica_1_id" {
  description = "ID de la Subnet Pública 1"
  value       = module.vpc.subnet_publica_1_id
}

output "subnet_publica_2_id" {
  description = "ID de la Subnet Pública 2"
  value       = module.vpc.subnet_publica_2_id
}

output "subnet_privada_1_id" {
  description = "ID de la Subnet Privada 1"
  value       = module.vpc.subnet_privada_1_id
}

output "subnet_privada_2_id" {
  description = "ID de la Subnet Privada 2"
  value       = module.vpc.subnet_privada_2_id
}