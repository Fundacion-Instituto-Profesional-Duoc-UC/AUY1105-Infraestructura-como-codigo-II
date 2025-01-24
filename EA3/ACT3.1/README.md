# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# MANIPULACIÓN DE ARCHIVOS DE ESTADO EN TERRAFORM

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

### 6. Archivo de estado de Terraform

El [archivo de estado de Terraform](https://developer.hashicorp.com/terraform/language/state) contiene las siguientes claves principales:

- version: Versión del formato del archivo de estado.
- terraform_version: Versión de Terraform utilizada para generar el archivo.
- serial: Número de serie del archivo de estado, que aumenta con cada cambio.
- lineage: Identificador único del archivo de estado.
- outputs: Valores de salida definidos en las configuraciones de Terraform.
- resources: Recursos gestionados por Terraform.
- check_results: Resultados de verificaciones, si las hay.

Para la ejecución práctica realizaremos las siguientes acciones:

1. **Revisar el Archivo de Estado**

Antes de realizar cualquier cambio, es importante entender el estado actual de los recursos gestionados por Terraform. El archivo de estado es crucial para saber qué recursos están siendo gestionados y cómo Terraform ha configurado tu infraestructura.

Abre el archivo de estado con un editor de texto o usa el comando:

```bash
terraform state list
```

Este comando te mostrará todos los recursos gestionados en tu estado actual. Es importante revisar esta lista antes de realizar cambios para saber el impacto que tendrá cualquier acción posterior.

2. **Realiza un backup del estado, como una buena práctica de resiliencia y recuperación**

Antes de realizar cualquier operación que modifique el estado de Terraform, como eliminar o agregar recursos, siempre es una buena práctica hacer una copia de seguridad del archivo de estado. Esto asegura que puedes restaurar la infraestructura a su estado anterior si algo sale mal.

```bash
terraform state pull > terraform.tfstate.bak
```

¿Por qué es importante realizar un backup? El archivo de estado es esencial para la operación de Terraform. Sin él, no podemos aplicar cambios de manera confiable ni hacer un seguimiento de qué recursos se han creado, modificado o destruido. El backup te permite restaurar el estado a un punto anterior si algo sale mal.

3. **Eliminar un recurso**

En este paso, eliminamos un recurso del estado de Terraform. Este comando no destruye el recurso en la nube, solo lo elimina del archivo de estado. Esto significa que Terraform dejará de gestionar ese recurso, pero el recurso continuará existiendo en la infraestructura.

```bash
terraform state rm module.ec2.aws_instance.mi_ec2
```

**¿Qué sucede cuando usamos terraform state rm?**
Este comando elimina el recurso del archivo de estado, lo que significa que Terraform ya no lo rastreará ni lo gestionará. El recurso permanece en la infraestructura, pero ya no se puede aplicar cambios a través de Terraform.

**¿Por qué usar terraform state rm?**
Este comando es útil si quieres que Terraform deje de gestionar un recurso sin destruirlo, por ejemplo, cuando estás manejando un recurso fuera de Terraform o si necesitas manejarlo manualmente.

**Comportamiento esperado:** 
El recurso mi_ec2 se eliminará del estado, pero no se destruirá en la infraestructura. Si intentamos aplicar Terraform nuevamente sin importarlo, Terraform intentará recrearlo, ya que el estado ahora no tiene conocimiento de este recurso.

```bash
terraform plan
```

```bash
terraform apply
```

**¿Qué sucede al aplicar los cambios?**
Terraform intentará crear de nuevo el recurso mi_ec2 en la infraestructura, aunque este ya exista. Esto se debe a que, desde la perspectiva de Terraform, el recurso fue eliminado del estado, por lo que lo considera un recurso a crear.

## TRABAJO AUTÓNOMO

Intenta realizar las acciones de revisar, agregar, mover, renombrar y eliminar sobre acciones y recursos diferentes en tu estado de terraform. Recuerda previamente realizar un backup de tu estado.

##  REFLEXIONES

- **Gestión Segura y Controlada del Estado:** Manipular los archivos de estado en Terraform es una actividad crítica que requiere planificación cuidadosa y medidas de seguridad para evitar inconsistencias y garantizar la estabilidad de la infraestructura.

- **Aprendizaje Práctico y Estructurado:** Proporcionar ejemplos claros y pasos detallados permite a los estudiantes adquirir habilidades prácticas para realizar tareas avanzadas, como mover, renombrar o importar recursos, de manera ordenada y sin comprometer la infraestructura.

- **Minimización de Riesgos:** Diseñar procedimientos seguros y realizar respaldos previos asegura que los estudiantes comprendan la importancia de mitigar riesgos al trabajar con archivos de estado, promoviendo prácticas confiables en la gestión de infraestructura como código.