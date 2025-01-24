# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# ESTRUCTURACIÓN DE UN MÓDULO BÁSICO DE TERRAFORM

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

### 6. Explora el contenido de las carpetas ec2_module y vpc_module

Explora el contenido de estas carpetas, y analiza como se relacionan con el siguiente código:

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

## TRABAJO AUTÓNOMO

El objetivo de esta sección es que los estudiantes apliquen los conocimientos adquiridos para desarrollar una solución propia utilizando Terraform y AWS. Sigue las indicaciones, pero personaliza cada aspecto para lograr un diseño que se ajuste a tus necesidades.

### Personalización del Módulo EC2
Modifica el archivo de configuración de Terraform para crear dos instancias EC2 adicionales con las siguientes características:

- Una instancia en una subred pública distinta a la ya configurada.
- Otra instancia en una subred privada.
- Cambia los nombres de las instancias y selecciona un tipo de instancia diferente (por ejemplo, t3.micro o el permitido en el laboratorio).

Ajusta las reglas de seguridad para que:

- La instancia en la subred pública permita acceso por SSH desde tu IP pública.
- La instancia en la subred privada pueda ser alcanzada desde la instancia pública mediante el puerto 22 (SSH).
- Genera un nuevo par de claves para las instancias adicionales y asegúrate de configurarlo en el código de Terraform.

### Creación de un Módulo Propio

Diseña un módulo nuevo llamado s3_module que permita crear un bucket de Amazon S3 con las siguientes características:

- Nombre único basado en un prefijo y un sufijo que defines en las variables del módulo.
- Habilitación del versionado de objetos.
- Reglas de acceso que permitan acceso público de solo lectura a los archivos.
- Agrega el módulo al archivo principal de Terraform y configúralo con tus propias variables.

## REFLEXIONES

- **Organización y escalabilidad:** Una estructura clara del módulo de Terraform facilita la colaboración, reduce errores y permite escalar la infraestructura como código de manera eficiente al adaptarse rápidamente a nuevos requerimientos.

- **Parametrización y reutilización:** Diseñar módulos modulares y flexibles promueve la reutilización en múltiples entornos, manteniendo consistencia y evitando duplicación de código, lo que optimiza el desarrollo y fomenta prácticas sostenibles.

- **Mejores prácticas y mantenimiento:** Seguir las mejores prácticas, como definir variables y salidas adecuadamente, asegura un código claro y manejable, reduciendo deuda técnica y garantizando la sostenibilidad del proyecto a largo plazo.