# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# ACTUALIZACIÓN MAYOR (MAJOR) CON COMPATIBILIDAD HACIA ATRÁS

## DESARROLLO DE ACTIVIDAD

Uso de comportamiento predeterminado, agregando en ec2_module en el archivo variables.tf el siguiente bloque.

```bash
variable "use_security_group" {
  description = "Habilitar o deshabilitar el grupo de seguridad SSH"
  type        = bool
  default     = true
}
```
Y ahora en el módulo, incluimos la variable para activar o desactivar esta funcionalidad.

```bash
module "ec2" {
  source             = "./ec2_module"
  key_name           = var.key_name
  public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami                = "ami-012967cc5a8c9f891"
  subnet_id          = module.vpc.subnet_publica_1_id
  vpc_id             = module.vpc.vpc_id
  instance_name      = var.instance_name
  use_security_group = false
}
```

Agregar en vpc_module en el archivo variables.tf

```bash
variable "enable_dns_support" {
  description = "Habilitar el soporte DNS para la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar los nombres DNS para las instancias dentro de la VPC"
  type        = bool
  default     = true
}
```

Modificar en el archivo main.tf

```bash
resource "aws_vpc" "mi_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}
```

## REFLEXIONES