# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# PRUEBAS DE COMPATIBILIDAD Y DOCUMENTACIÓN DE RESULTADOS

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

### 6. Ejecución de Pruebas

Para la realización de las pruuebas, utilizaremos terratest, el cual nos ayudará mediante un archivo previamente construido, ejecutar pruebas sobre nuestro módulo, específicamente sobre el de VPC.

Para ello, primero deberemos previamente instalar las dependencias necesarias para la ejecución de nuestras pruebas:

```bash
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/gruntwork-io/terratest/modules/test-structure
go get github.com/gruntwork-io/terratest/modules/aws
go get github.com/stretchr/testify/assert
```

Ya instaladas las dependencias, ejecutaremos el siguiente comando, para ejecutar las pruebas y analizar el resultado:

```bash
go test -v vpc_module_test/vpc_test.go
```

Para forzar un comportamiento erróneo, modificaremos en el archivo vpc_module_test/vpc_test.go de la siguiente manera

**ANTES**
```bash
EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},
```
**DESPUÉS**
```bash
EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-west-1",
		},
```

Volvemos a ejecutar las pruebas, y analizamos el resultado:

```bash
go test -v vpc_module_test/vpc_test.go
```

## TRABAJO AUTÓNOMO

Siguiendo la estructura de carpetas/archivos, crea una carpeta llamada **ec2_module_test** y dentro un archivo llamado **ec2_test.go** e intenta construir tus pruebas asociadas al módulo de EC2.

## REFLEXIONES

- **Garantizar la integridad de la infraestructura:** Las pruebas automatizadas permiten verificar que los cambios en el módulo no afecten versiones anteriores, asegurando que la infraestructura existente siga funcionando correctamente y sin interrupciones, incluso después de actualizaciones importantes.

- **Simulación de escenarios y detección de conflictos:** Simular diferentes escenarios de actualización ayuda a identificar posibles conflictos entre versiones y a anticipar problemas antes de que afecten el entorno de producción, lo que mejora la confiabilidad del módulo.

- **Documentación clara y accesible de los resultados:** Elaborar reportes claros y detallados sobre los resultados de las pruebas, destacando incompatibilidades y proporcionando recomendaciones, fomenta la transparencia y facilita que los usuarios comprendan los posibles impactos de las actualizaciones, mejorando la confianza en el módulo.