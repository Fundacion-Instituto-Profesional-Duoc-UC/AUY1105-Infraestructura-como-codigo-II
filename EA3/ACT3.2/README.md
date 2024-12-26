# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# RECUPERACIÓN DE ESTADO Y MANEJO DE ERRORES

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

### Recuperar un estado de terraform

1. **Realizar Backup de archivo de estado**

Abre el archivo de estado con un editor de texto o usa el comando:

```bash
terraform state list
```

Realiza un backup del estado, como una buena práctica de resiliencia y recuperación:

```bash
terraform state pull > terraform.tfstate.bak
```

2. **Alterar elemento para modificar el estado**

```bash
terraform state rm module.ec2.aws_instance.mi_ec2
```

Desde la consola de AWS, elimina la instancia previamente creada de manera manual. Luego deberás ejecutar un **terraform plan** y un **terraform apply**

```bash
terraform plan
```

```bash
terraform apply
```

3. **Recuperar el respaldo del archivo de estado de terraform**

```bash
cp terraform.tfstate terraform.tfstate.broken
cp terraform.tfstate.backup terraform.tfstate
```

Desde la consola de AWS, elimina la instancia previamente creada de manera manual. Luego deberás ejecutar un **terraform plan** y un **terraform apply**

```bash
terraform plan
```

```bash
terraform apply
```

## TRABAJO AUTÓNOMO

Intenta realizar la accion de modificar el estado sobre acciones y recuperarlo de manera segura. Recuerda previamente realizar un backup de tu estado.

##  REFLEXIONES

- **La importancia de las copias de seguridad:** Durante la realización de esta actividad, se destaca el valor crítico de mantener copias de seguridad actualizadas del archivo de estado de Terraform. Este archivo actúa como la única fuente de verdad para la infraestructura gestionada, y su pérdida puede causar desajustes significativos entre los recursos reales y la configuración deseada. Implementar políticas de respaldo y automatizar su gestión no solo protege contra fallos técnicos, sino que también reduce el tiempo de recuperación en situaciones de crisis.

- **Comprensión de los riesgos asociados al estado:** La actividad permite comprender que los archivos de estado no solo son susceptibles a errores humanos, como eliminaciones accidentales, sino también a problemas técnicos, como corrupción de datos o errores de sincronización con backends remotos. Gestionar adecuadamente el estado implica no solo proteger el archivo, sino también implementar controles que minimicen los riesgos, como el uso de almacenamiento remoto seguro y configuraciones adecuadas en Terraform.

- **Preparación para manejar imprevistos:** Este ejercicio subraya la importancia de estar preparado para enfrentar situaciones inesperadas relacionadas con el estado de Terraform. Más allá de la restauración técnica, se fomenta el desarrollo de habilidades analíticas para diagnosticar problemas, tomar decisiones rápidas y garantizar la continuidad operativa. Documentar procedimientos y reflexionar sobre las lecciones aprendidas es clave para fortalecer las estrategias de recuperación y mejorar la resiliencia de los entornos gestionados.