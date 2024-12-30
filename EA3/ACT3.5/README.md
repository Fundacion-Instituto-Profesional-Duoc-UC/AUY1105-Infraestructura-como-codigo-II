# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# GESTIÓN DEL ESTADO CON COMANDOS AVANZADOS

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

6. Verificar el estado con terraform show

Ejecutar el siguiente comando para obtener detalles sobre el estado actual de la infraestructura:

```bash
terraform show
```

Examina la salida de este comando para identificar el estado actual de la instancia EC2, volumen EBS y su relación.

7. Bloquear el estado con terraform state lock (Para esto, se debe implementar un backend como HCP)

Simularemos un escenario donde el archivo de estado de Terraform se bloquea para evitar cambios concurrentes.

```bash
terraform state lock
```

8. Realizar un cambio manual (taint) con terraform taint

Simularemos una modificación manual en el estado de un recurso para marcarlo como dañado, lo que obligará a Terraform a recrearlo en la siguiente ejecución.

```bash
terraform taint aws_instance.web
```

Ejecutar el comando terraform plan nuevamente y observar cómo Terraform planea recrear la instancia EC2. Después, ejecutar terraform apply para aplicar el cambio y ver si la instancia se recrea.

9. Refrescar el estado con terraform refresh

Si algún recurso ha sido modificado fuera de Terraform (por ejemplo, en la consola de AWS), el estado de Terraform puede quedar desactualizado.

```bash
terraform refresh
```

Verificar que el estado de la infraestructura se haya actualizado y que coincida con los cambios realizados manualmente (si los hay).


##  REFLEXIONES

- **Importancia de la gestión del estado en entornos colaborativos:** La correcta gestión del estado con comandos como terraform state lock y terraform state unlock es crucial para evitar cambios concurrentes que puedan comprometer la estabilidad de la infraestructura, especialmente en equipos de trabajo colaborativos. Mantener un estado consistente asegura que todos los miembros del equipo trabajen sobre la misma base y previene posibles conflictos.

- **El valor de los comandos terraform taint y terraform refresh:** Los comandos como terraform taint y terraform refresh permiten manejar de manera eficiente los recursos y su estado, facilitando la detección de discrepancias entre la infraestructura real y la gestionada por Terraform. Estas herramientas son esenciales para mantener la infraestructura alineada con las expectativas, permitiendo actualizaciones sin problemas.

- **La importancia de la consistencia y la integridad del estado:** La consistencia del estado es fundamental para evitar errores o inconsistencias durante la ejecución de los cambios. Comandos como terraform show y terraform refresh permiten verificar y actualizar el estado de la infraestructura, garantizando que las decisiones y acciones de Terraform reflejen correctamente el entorno real. La correcta manipulación del estado mejora la seguridad y confiabilidad de los cambios realizados.