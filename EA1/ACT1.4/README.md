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

Ejecuta el siguiente comando para inicializar el entorno de Terraform (si no lo has hecho ya):

```bash
terraform init
terraform plan
terraform apply
```
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


Reflexionamos sobre los cambios aplicados y comentamos sobre:

1. Transparencia y Trazabilidad
Un changelog bien mantenido proporciona transparencia sobre los cambios realizados en el proyecto, lo que facilita a cualquier miembro del equipo (o a las partes interesadas) comprender qué modificaciones se han hecho, cuándo y por qué. Esto es crucial cuando varios colaboradores trabajan en un mismo proyecto, ya que permite entender el impacto de las decisiones tomadas a lo largo del tiempo. Además, la trazabilidad es vital para auditar la infraestructura y las configuraciones que se despliegan.

2. Historial de Cambios
El changelog actúa como un registro histórico de los cambios en el proyecto. En proyectos de infraestructura como código, cada cambio puede implicar modificaciones en la arquitectura, configuración de recursos, o políticas de seguridad. Documentar adecuadamente estos cambios asegura que el historial completo esté disponible y accesible. Esto es útil no solo para la colaboración en equipo, sino también para solucionar problemas en el futuro. Si se presenta un fallo o una incidencia, un changelog detallado puede ayudar a identificar rápidamente qué cambio causó el problema.

3. Comunicación Eficaz entre Equipos
Un changelog sirve como una herramienta de comunicación entre equipos de desarrollo, operaciones y otros interesados. Al mantener un changelog actualizado y claro, se facilita la comprensión de los cambios que afectan a la infraestructura. Además, un buen changelog puede ayudar a alinear a todos los equipos respecto a la versión y estado actual del proyecto, evitando malentendidos o problemas debido a versiones desactualizadas o mal gestionadas.

4. Documentación de Decisiones
A menudo, en proyectos de infraestructura, las decisiones que se toman tienen implicaciones más allá del código inmediato. Por ejemplo, cambiar una configuración de seguridad o actualizar una política de acceso puede tener un impacto en la arquitectura o en la privacidad de los datos. Mantener un changelog ayuda a documentar esas decisiones de manera explícita, lo que resulta valioso cuando se necesita justificar una decisión ante un cliente, auditoría o durante la planificación de futuras modificaciones.

5. Facilita la Colaboración y el Trabajo en Equipo
Un changelog bien estructurado facilita la colaboración en equipo al permitir que todos los miembros del equipo tengan acceso a la misma información. En un entorno de infraestructura como código, los cambios pueden ser rápidos y frecuentes, por lo que tener una fuente centralizada y actualizada de todos los cambios reduce la posibilidad de que se pasen por alto detalles importantes.

6. Mejora la Gestión de Versiones
El control de versiones no solo es relevante para el código, sino también para la infraestructura. Mantener un changelog permite llevar un control de las versiones de las configuraciones y recursos gestionados. Cuando se trabaja con Terraform, por ejemplo, las actualizaciones de infraestructura a menudo deben ser revisadas y aprobadas antes de su despliegue. Tener un changelog claro ayuda a gestionar estos cambios de manera eficiente, ya que proporciona una línea de tiempo de las versiones previas y las actualizaciones, lo que es crucial para la planificación de nuevos despliegues.

7. Mejora la Experiencia de los Desarrolladores
Cuando un equipo de desarrollo trabaja con infraestructura como código, tener un changelog bien estructurado les ayuda a reducir la curva de aprendizaje. Nuevos desarrolladores o colaboradores pueden consultar el changelog para entender rápidamente cómo ha evolucionado el proyecto, las versiones anteriores y las decisiones clave que se tomaron, sin tener que revisar todo el código o preguntar a otros miembros del equipo.

