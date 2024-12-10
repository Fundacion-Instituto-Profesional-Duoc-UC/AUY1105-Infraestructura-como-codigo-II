# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# USO DE VERSIONADO SEMÁNTICO DE UN MÓDULO

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

### 6. Generación de un Release en Github

Crea, una version de un release en tu repositorio local, lo puedes hacer siguiendo la referencia de [Github Release](https://docs.github.com/es/repositories/releasing-projects-on-github/managing-releases-in-a-repository)

Una vez que lo tengas, reemplaza en el campo source en tu archivo **main.tf** de la siguiente forma:

```bash
module "vpc" {
  source                = # ACÁ DEBE IR LA URL DE TU RELEASE
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  subnet_publica_1_cidr = var.subnet_publica_1_cidr
  subnet_publica_2_cidr = var.subnet_publica_2_cidr
  subnet_privada_1_cidr = var.subnet_privada_1_cidr
  subnet_privada_2_cidr = var.subnet_privada_2_cidr
  az_1                  = "us-east-1a"
  az_2                  = "us-east-1b"
}

module "ec2" {
  source        = # ACÁ DEBE IR LA URL DE TU RELEASE
  key_name      = var.key_name
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
  ami           = "ami-012967cc5a8c9f891"
  subnet_id     = module.vpc.subnet_publica_1_id
  vpc_id        = module.vpc.vpc_id
  instance_name = var.instance_name
}
```

Ejecuta nuevamente el comando para inicializar el entorno de Terraform:

```bash
terraform init
terraform plan
terraform apply
```

## TRABAJO AUTÓNOMO

Intenta realizar el mismo ejercicio, pero realizando un release de un MINOR y un PATCH.

## REFLEXIONES

- **Claridad en la gestión de actualizaciones:** Aplicar versionado semántico proporciona una forma estructurada de comunicar el impacto de los cambios en un módulo, permitiendo a los usuarios anticipar cómo las actualizaciones afectarán sus implementaciones.

- **Compatibilidad y estabilidad del código:** Implementar estrategias para garantizar la compatibilidad retroactiva y manejar transiciones sin interrupciones asegura la estabilidad del código, reduciendo riesgos y facilitando la adopción de nuevas versiones.

- **Colaboración y comunicación efectiva:** Documentar cambios en archivos de notas de versión (changelogs) promueve la transparencia y mejora la colaboración entre equipos, asegurando que todos comprendan las actualizaciones y su propósito.