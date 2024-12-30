# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# MIGRACIÓN Y MODIFICACIÓN DEL ESTADO

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
export HCP_API_TOKEN=<tu_hcp_api_token>
```

Ejecuta el siguiente comando para inicializar el entorno de Terraform (si no lo has hecho ya):

```bash
terraform init
terraform plan
terraform apply
```

6. Configuración de HCP para un Backend Remoto:

Para poder avanzar, necesitamos previamente realizar nuestra propia configuracion de un backend remoto mediante HCP, para ello deberemos seguir los siguientes pasos:

- Crear una organización, siguiendo la [documentación oficial](https://developer.hashicorp.com/hcp/docs/hcp/admin/orgs#create-an-organization)

- Crear un workspace, siguiendo la [documentación oficial](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-workspace-create)

- Definir variables de AWS, siguiendo la [documentación oficial](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-multiple-variable-sets)

7. Aplicar cambios en el código

Descomentar lineas de código comentadas en los siguientes archivos:

- **variables.tf:** Habilitar la variable que define el HCP Token.
- **provider.tf:** Habilitar la definición del provider con la organización y el workspace, junto con la definición del provider.

8. Ejecución de actualización con estos cambios

Primero, debemos hacer un [terraform login](https://developer.hashicorp.com/terraform/cli/commands/login) y previamente deberemos haber creado un [terraform token](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login#generate-a-token)

```bash
terraform login
```

Posteriormente, haremos un terraform init, donde nos pedirá confirmación de la migración de nuestro backend local a un backend remoto.

```bash
terraform init
```
Para mayor detalle, podemos revisar la [documentación oficial de migración](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate)

Para finalizar el proceso de migración, realizaremos un refresh para actualizar nuestro nuevo estado migrado:

```bash
terraform apply -refresh-only
```

Verifica que ahora en el state del workspace en tu organización, tienes el estado de terraform ya migrado.

##  REFLEXIONES

- **Gestión del estado en Terraform:** Los estudiantes aprenden la importancia de gestionar correctamente el estado de Terraform, ya que es esencial para mantener la consistencia de los recursos y evitar errores en la infraestructura.

- **Backend remoto para colaboración:** Migrar de un backend local a uno remoto con HCP facilita la colaboración, asegurando que el estado esté centralizado y accesible por todo el equipo, lo que mejora la eficiencia y la seguridad.

- **Integración con herramientas en la nube:** La actividad permite a los estudiantes desarrollar habilidades en la automatización de la infraestructura y la gestión de credenciales, lo cual es clave para trabajar en entornos de nube y con herramientas de infraestructura como código.

