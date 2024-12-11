# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# CREACIÓN DE POLÍTICAS BÁSICAS DE SEGURIDAD

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

### 5. Ejecutar código Terraform

1. Ejecuta el comando para inicializar el entorno de Terraform y descargar los providers necesarios.

```bash
terraform init
```

2. Exportar las Credenciales de AWS 
```bash
export AWS_ACCESS_KEY_ID=<tu_access_key_id>
export AWS_SECRET_ACCESS_KEY=<tu_secret_access_key>
export AWS_SESSION_TOKEN=<tu_session_token>
```

3. Generar el Plan de Terraform en Formato Binario
```bash
terraform plan -out=tfplan
```

4. Convertir el Plan Binario a Formato JSON
```bash
terraform show -json tfplan > tfplan.json
```

5. Evaluar la Política con OPA
Utiliza OPA para verificar que el plan cumpla con las políticas definidas en el archivo terraform_security.rego

```bash
opa eval -i tfplan.json -d terraform_security.rego "data.terraform.authz.allow"
```
Si se detecta una clave SSH no permitida, el resultado será:

```bash
{ "result": [true] }
```

6. Modifica el valor de la llave en el archivo main.tf

Cambia el valor del atributo public_key de la siguiente forma:

```bash
public_key = "ssh-rsa BAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
```

Ejecuta nuevamente la evaluación de la política, y valida los resultados

```bash
opa eval -i tfplan.json -d terraform_security.rego "data.terraform.authz.allow"
```

## TRABAJO AUTÓNOMO

Crea una politica asociada a otro recurso, siguiendo esta [documentación](https://www.openpolicyagent.org/docs/latest/terraform/), puedes utilizar como referencia cualquier recurso permitido dentro del Laboratorio de AWS.

## REFLEXIONES

- **Fortalecimiento de la seguridad y cumplimiento:** La implementación de políticas con Open Policy Agent (OPA) permite reforzar estándares de seguridad, asegurando que la infraestructura gestionada con Terraform cumpla con regulaciones organizacionales y normativas específicas.

- **Prevención de errores y vulnerabilidades:** Establecer controles declarativos ayuda a los equipos a identificar configuraciones inseguras o inapropiadas en el código IaC antes de la implementación, reduciendo riesgos y mejorando la confiabilidad del entorno.

- **Estandarización y eficiencia operativa:** Utilizar OPA fomenta una validación automatizada y centralizada de políticas, simplificando la adopción de buenas prácticas y garantizando consistencia en el manejo de infraestructuras a lo largo de los equipos.