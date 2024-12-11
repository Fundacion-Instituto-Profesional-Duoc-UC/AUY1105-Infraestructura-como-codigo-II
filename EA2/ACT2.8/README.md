# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# IMPLEMENTACIÓN DE CAMBIOS CON DOCUMENTACIÓN DE MIGRACIÓN

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
```

### 6. Crear un archivo de S3 Deprecado

1. Pega en un nuevo archivo llamado s3.tf el siguiente bloque de código:

```bash
resource "aws_s3_bucket" "mi_s3" {
  bucket = "mi-s3"

  website {
    index_document = "index.html"
  }
}
```

Ejecuta un **terraform plan** y evalúa los resultados. Posterior a esto, haremos un cambio en el archivo provider.tf agregando el siguiente bloque de código:

```bash
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
```

Ejecutaremos el comando **terraform init -upgrade** para actualizar la versión del provider, y evaluaremos los resultados mediante un **terraform plan**. Recibiremos un Warning asociado al bloque **website_configuration** dentro de nuestro código, por lo cual, deberemos reemplazar en nuestro archivo s3.tf algunas configuraciones:

```bash
resource "aws_s3_bucket" "mi_s3" {
  bucket = "mi-s3"
}

resource "aws_s3_bucket_website_configuration" "mi_s3" {
  bucket = aws_s3_bucket.mi_s3.bucket

  index_document {
    suffix = "index.html"
  }
}
```

Volvemos a ejecutar un **terraform plan** y ahora nuestro resultado, no debiera tener Warnings asociados, por lo cual ahora podremos realizar el **terraform apply**.

## REFLEXIONES

- **Planificación cuidadosa para actualizaciones de módulos:** La guía resalta la importancia de planificar adecuadamente los cambios en los módulos de Terraform para asegurar que las actualizaciones se realicen de manera ordenada y controlada. Esta planificación no solo reduce riesgos, sino que también ayuda a prevenir interrupciones durante el proceso de migración.

- **Documentación detallada y accesible:** Al proporcionar una documentación clara y detallada sobre los pasos a seguir en la migración de versiones, los estudiantes podrán crear guías que permitan a los usuarios implementar actualizaciones sin dificultades. Este enfoque también facilita la comprensión de las decisiones y configuraciones que impactan las versiones de los módulos.

- **Manejo de riesgos y transición fluida:** La clave para garantizar una transición exitosa entre versiones es la identificación temprana de los cambios críticos y la implementación de estrategias de actualización que minimicen los riesgos. Documentar posibles problemas y soluciones garantiza que los usuarios puedan gestionar los cambios con confianza y sin interrupciones.