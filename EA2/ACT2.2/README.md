# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# IMPLEMENTACIÓN DE VARIABLES Y PARÁMETROS EN EL MÓDULO

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

### 6. Analiza el uso de variables

Realiza una comparativa en la implementación del módulo, con y sin el uso de variables, para ello podemos revisar la comparativa, y el detalle de las variables en el archivo variables.tf

```bash
module "vpc" {
  source                = "./vpc_module"
  vpc_cidr              = "10.1.0.0/16"
  vpc_name              = "mi-vpc-principal"
  subnet_publica_1_cidr = "10.1.1.0/24"
  subnet_publica_2_cidr = "10.1.2.0/24"
  subnet_privada_1_cidr = "10.1.3.0/24"
  subnet_privada_2_cidr = "10.1.4.0/24"
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = "./ec2_module"
  key_name      = "mi_key_name"
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = "MiInstancia"
}
```

```bash
module "vpc" {
  source                = "./vpc_module"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  subnet_publica_1_cidr = "10.1.1.0/24"
  subnet_publica_2_cidr = "10.1.2.0/24"
  subnet_privada_1_cidr = "10.1.3.0/24"
  subnet_privada_2_cidr = "10.1.4.0/24"
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = "./ec2_module"
  key_name      = var.key_name
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = var.instance_name
}
```

## TRABAJO AUTÓNOMO

Para reforzar los conocimientos adquiridos, realiza las siguientes actividades:

### Personalizar los Módulos:

- Crea una nueva variable en el archivo variables.tf para definir el nombre del grupo de seguridad de tu instancia EC2.
- Modifica el módulo ec2 para utilizar esta nueva variable en lugar de un valor fijo.
- Verifica que tu infraestructura se despliegue correctamente con este cambio.

### Agregar Funcionalidad Adicional:

- Modifica el módulo vpc para agregar un tercer rango de subred pública (10.1.5.0/24). Asegúrate de que los recursos relacionados se actualicen adecuadamente.

### Identificar y Solucionar Errores:

- Intenta renombrar una variable en el archivo variables.tf y ajusta todas las referencias correspondientes. Observa cómo Terraform identifica los errores y soluciona cualquier problema que surja.

### Documentar el Proceso:

- Escribe un breve documento o realiza una presentación que explique los pasos seguidos para realizar los cambios anteriores, los retos enfrentados y cómo los resolviste.

## REFLEXIONES

- **Flexibilidad y adaptabilidad del módulo:** El uso de variables permite personalizar configuraciones clave sin modificar el código base, facilitando la implementación en múltiples entornos y promoviendo una infraestructura adaptable y eficiente.

- **Consistencia y validación de entradas:** La definición de valores predeterminados y la validación de entradas aseguran que los parámetros sean consistentes y cumplan con los requisitos del proyecto, reduciendo errores y aumentando la confiabilidad del módulo.

- **Reutilización y exposición de información clave:** Utilizar outputs estratégicamente facilita la integración y reutilización del módulo, exponiendo datos esenciales para otros componentes y mejorando la interoperabilidad entre módulos.