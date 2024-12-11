# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# REGISTRO DE CAMBIOS Y VERSIONADO

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

Para conectar correctamente a la instancia generada, asegurate que en el archivo **ec2.tf** actualices el valor de **public_key** con el que generaste a partir del manual **Manual Creación Llave SSH**

```bash
resource "aws_key_pair" "mi_key" {
  key_name   = "mi_key_name"
  public_key = # MI LLAVE PUBLICA
}
```

Intenta conectar con la Instancia EC2 que creaste a partir del código terraform, y verifica que con tu llave privada y el comando de conexión puedas establecer la conexión mediante SSH.

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

### 5. Modificar el Código Terraform

Actualiza el recurso `aws_security_group` para restringir el acceso SSH a una dirección IP específica (por ejemplo, `192.168.1.100/32`):

```bash
resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Permitir acceso SSH desde una IP específica"
  vpc_id      = aws_vpc.mi_vpc.id

  ingress {
    description = "SSH desde IP específica"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.100/32"] # Acceso solo desde esta IP
  }

  egress {
    description = "Permitir tráfico de salida a cualquier lugar"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-access"
  }
}
```

### 6. Aplicar los Cambios en Terraform

```bash
terraform apply
```
Intenta conectar con la Instancia EC2 que actualizaste a partir del código terraform, y verifica que con tu llave privada y el comando de conexión puedas establecer la conexión mediante SSH, ya no deberías poder hacerlo, debido a que ahora la única IP de Acceso es la que se definió en el bloque nuevo de código, por motivos de seguridad. (**192.168.1.100/32**)

### 7. Actualizar el Archivo CHANGELOG.md

Modifica el archivo CHANGELOG.md en el directorio del proyecto y añade una nueva entrada documentando el cambio realizado.

```bash
## [1.0.2] - FECHA
### Agregado
- Actualización del grupo de seguridad `ssh_access` para restringir el acceso SSH solo a la IP `192.168.1.100/32`.
```

4. Subir los Cambios a GitHub
```bash
git add .
git commit -m "Actualización de grupo de seguridad SSH y changelog"
git push origin main
```

5. Crear un Release en GitHub

- En tu repositorio de GitHub, ve a la sección de Releases en la página principal del repositorio.

- Haz clic en Draft a new release.

- En la sección de Tag version, escribe v1.0.2 para marcar el nuevo release.

- En la sección Release title, escribe un título como "Actualización de grupo de seguridad para acceso SSH".


## TRABAJO AUTÓNOMO

Intenta realizar algun otro cambio que consideres pertinente, y genera un nuevo TAG, Release y actualiza el Changelog de acuerdo a lo visto en clases.

## REFLEXIONES

- **Mejora en la comunicación y colaboración:** El uso de changelogs y convenciones de versionado semántico asegura que los equipos puedan entender y rastrear los cambios en el proyecto de manera eficiente. Esto fomenta una comunicación clara entre los desarrolladores y usuarios finales sobre las actualizaciones y el progreso del software.

- **Mantenimiento y evolución del proyecto:** Establecer lineamientos claros para la gestión de versiones facilita la identificación de problemas potenciales, asegura la compatibilidad entre versiones y simplifica el mantenimiento a largo plazo del código.

- **Transparencia y confianza:** Un flujo de trabajo bien documentado en GitHub mejora la confianza de los usuarios finales y de los colaboradores al ofrecer visibilidad sobre la evolución del software y las decisiones tomadas a lo largo del tiempo.