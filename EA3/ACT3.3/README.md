# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# SIMPLIFICACIÓN DE CONFIGURACIONES

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

### 6. Crea tu propio módulo

1. Sigue una estructura de carpetas recomendada:

```bash
project-root/
|-- modules/                # Módulos reutilizables
|   |-- vpc/                # Módulo para la VPC
|   |-- ec2/                # Módulo para EC2
|-- environments/           # Configuraciones por entorno
|   |-- dev/
|   |-- staging/
|   |-- prod/
|-- variables.tf            # Variables globales
|-- outputs.tf              # Salidas globales
|-- main.tf                 # Configuración principal
|-- providers.tf            # Proveedores utilizados
|-- terraform.tfvars        # Valores por defecto
```

2. Crea Módulos Reutilizables

Estructura del módulo:

```bash
modules/vpc/
|-- main.tf       # Lógica principal del recurso
|-- variables.tf  # Variables del módulo
|-- outputs.tf    # Salidas del módulo
```

Archivo main.tf del módulo:

```bash
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}
```

Archivo variables.tf del módulo:

```bash
variable "cidr_block" {
  description = "CIDR para la VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar hostnames DNS"
  type        = bool
  default     = true
}
```

3. Utilizar Variables de Forma Eficiente

Definimos variables reutilizables en variables.tf y especificamos valores en terraform.tfvars:

Archivo variables.tf global:

```bash
variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-west-2"
}
```

Archivo terraform.tfvars:

```bash
region = "us-east-1"
```

Simplifique configuraciones utilizando bloques locals:

```bash
locals {
  common_tags = {
    Environment = var.environment
    Project     = "ExampleProject"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  tags          = local.common_tags
}
```

4. Uso de bloques compartidos:

Si varios recursos utilizan reglas similares de seguridad:

```bash
resource "aws_security_group_rule" "allow_ssh" {
  for_each = toset(["sg-1", "sg-2"])

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = each.key
  cidr_blocks       = ["0.0.0.0/0"]
}
```

5. Uso de estado remoto

Crea tu cuenta en [Terraform registry](https://app.terraform.io/public/signup/account) y almacena el estado de terraform en un estado remoto, para hacerlo deberás implementar en tu código lo siguiente:

```bash
terraform {
  backend "remote" {
    organization = "my-organization"  # Reemplaza con tu organización en HCP
    workspaces {
      name = "my-workspace"  # El nombre del workspace que deseas utilizar
    }
  }
}
```

A partir de los módulos entregados en clases, intenta realizar estas mejoras en tu código para que sean implementadas, y realiza un **pull request** una vez hayas terminado que será revisado por el docente.

##  REFLEXIONES

- **Importancia de la Organización:** Mantener una estructura clara y modular de los archivos de configuración no solo mejora la legibilidad, sino que facilita el trabajo colaborativo y reduce errores al gestionar proyectos complejos.

- **Reutilización y Escalabilidad:** La modularización y el uso de variables permiten crear configuraciones más flexibles y adaptables. Esto es clave para manejar proyectos que requieren ajustes frecuentes o escalan a múltiples entornos.

- **Mantenimiento a Largo Plazo:** Una estructura modular bien organizada facilita el mantenimiento y la evolución del proyecto a lo largo del tiempo. Al tener configuraciones separadas y claras, es más sencillo identificar áreas que necesitan ajustes o actualizaciones sin afectar otras partes del sistema. Esto también ayuda a reducir el riesgo de introducir errores cuando se realizan modificaciones, lo que es esencial en proyectos de largo plazo o cuando se trabaja con equipos grandes.