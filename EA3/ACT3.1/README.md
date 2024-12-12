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

Abre el archivo de estado con un editor de texto o usa el comando:

```bash
terraform state list
```

Realiza un backup del estado, como una buena práctica de resiliencia y recuperación:

```bash
cp terraform.tfstate terraform.tfstate.bak
```

2. **Agregar**

Si necesitas gestionar un recurso existente con Terraform:

```bash
terraform import module.vpc.aws_eip.nat_eip eipalloc-12345678
```

**terraform import:** Este comando asocia el recurso existente (en este caso, un EIP identificado por eipalloc-12345678) con la configuración de Terraform. Asegura que Terraform comience a gestionar este recurso.

Después de importar, revisa que el estado y la configuración sean consistentes:

```bash
terraform plan
```

Si el plan es correcto, ejecuta:

```bash
terraform apply
```

3. **Mover**

```bash
terraform state mv module.ec2.aws_instance.mi_ec2 module.new_ec2.aws_instance.mi_ec2
```

```bash
terraform plan
```

```bash
terraform apply
```

4. **Renombrar**

```bash
terraform state mv module.ec2.aws_key_pair.mi_key module.ec2.aws_key_pair.new_key
```

```bash
terraform plan
```

```bash
terraform apply
```

5. **Eliminar**

```bash
terraform state rm module.ec2.aws_security_group.ssh_access
```

```bash
terraform plan
```

```bash
terraform apply
```

##  REFLEXIONES