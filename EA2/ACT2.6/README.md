# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# ACTUALIZACIÓN MAYOR (MAJOR) CON COMPATIBILIDAD HACIA ATRÁS

## DESARROLLO DE ACTIVIDAD

### 1. Iniciar el Laboratorio Learner Lab en AWS Academy

1. Accede a **AWS Academy** y selecciona el curso correspondiente.  
2. Inicia el laboratorio Learner Lab haciendo clic en **Start Lab**.  
3. Accede a la consola de AWS utilizando las credenciales temporales proporcionadas.

### 2. Crear una Instancia EC2

1. En la consola de AWS, ve al servicio **EC2**.  
2. Haz clic en **Launch Instance** y configura los siguientes parámetros:
   - Nombre: `Infraestructura-Actividad`
   - Tipo de instancia: `t2.micro` (o el disponible en el lab)
   - AMI: **Amazon Linux 2**
   - Configura el almacenamiento y revisa las reglas de seguridad (permitir SSH, puerto 22).  

3. Haz clic en **Launch** y selecciona o crea un par de claves para conectarte.

### 3. Conectarse a la Instancia EC2

1. Una vez que la instancia esté corriendo, haz clic en **Connect** y sigue las instrucciones para conectarte mediante SSH.  
2. Usa el siguiente comando (ajustando el archivo de clave):

```bash
   ssh -i "nombre-de-tu-clave.pem" ec2-user@<dirección-ip-pública>
```

### 4. Subir y Ejecutar el Script install.sh

1. Sube el archivo a la instancia EC2:

```bash
   scp -i "nombre-de-tu-clave.pem" install.sh ec2-user@<dirección-ip-pública>:~
```

2. Conéctate nuevamente a la instancia y ejecuta el script:

```bash
chmod +x install.sh
./install.sh
```

### 5. Aplicar los Cambios en Terraform

Exporta las Credenciales de AWS 
```bash
export AWS_ACCESS_KEY_ID=<tu_access_key_id>
export AWS_SECRET_ACCESS_KEY=<tu_secret_access_key>
export AWS_SESSION_TOKEN=<tu_session_token>
```

Ejecuta el siguiente comando para inicializar el entorno de Terraform (si no lo has hecho ya):

```bash
terraform init
terraform plan
terraform apply
```

### 6. Uso de comportamiento predeterminado 

Realizaremos un caso práctico de comportamiento predeterminado, agregando en ec2_module en el archivo variables.tf el siguiente bloque.

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

Ejecutamos nuevamente el comando para inicializar el entorno de Terraform:

```bash
terraform init
terraform plan
terraform apply
```

## TRABAJO AUTÓNOMO

Analiza, si en el archivo **vpc_module/main.tf** en el bloque que se adjunta, se podría establecer un comportamiento predeterminado.

```bash
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
```

## REFLEXIONES

- **Cambios significativos sin interrumpir la infraestructura:** Implementar actualizaciones mayores de manera controlada permite introducir cambios importantes en la funcionalidad del módulo sin afectar la infraestructura existente ni los usuarios actuales, asegurando que las actualizaciones no interrumpan entornos productivos.

- **Compatibilidad y control de versiones condicionales:** Al identificar los cambios que requieren una actualización mayor y aplicar versiones condicionales, los usuarios pueden seguir utilizando versiones anteriores sin problemas, mientras que los nuevos usuarios o aquellos que decidan actualizar pueden aprovechar las mejoras de la versión mayor.

- **Documentación y migración clara:** Proveer documentación detallada sobre los cambios introducidos y ofrecer instrucciones de migración claras facilita la transición para los usuarios, permitiéndoles adaptar sus configuraciones sin esfuerzo y asegurando que las actualizaciones se apliquen de forma segura.