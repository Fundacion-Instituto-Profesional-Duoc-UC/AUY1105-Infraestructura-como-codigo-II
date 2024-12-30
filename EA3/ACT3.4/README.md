# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# IMPLEMENTACIÓN DE EFICIENCIA EN LA CONFIGURACIÓN

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

6. Revisa el archivo teraform.tf adjunto, y analiza posibles mejoras en base a lo aprendido que se puedan implementar:

- **Organización de archivos:** Mantener una estructura modular que separe los diferentes componentes del código en archivos específicos mejora la claridad, facilita el mantenimiento y favorece el trabajo en equipo.
- **Versiones requeridas:** Bloquea versiones de proveedores para evitar cambios no controlados.
- **Hardcoded values:** Regiones, zonas de disponibilidad y otros valores están codificados, lo que dificulta la reutilización y escalabilidad.
- **Dependencias no explícitas:** Terraform podría no entender el orden correcto de los recursos.
- **Sin paralelización:** No se utilizan técnicas que permitan aprovechar la ejecución paralela.
- **Backend sin configuración:** No se utiliza un backend remoto para almacenar el estado.


7. Una vez que apliques los cambios, ejecuta el siguiente comando para inicializar el entorno de Terraform (si no lo has hecho ya):

```bash
terraform init
terraform plan
terraform apply
```

##  REFLEXIONES

- **La optimización como base de la gestión eficiente:** La actividad muestra cómo optimizar la ejecución de Terraform mejora la productividad al reducir tiempos de aplicación y recursos utilizados. Estas mejoras son clave para equipos que trabajan en sistemas complejos, ya que permiten disminuir tiempos de inactividad y aumentar la disponibilidad de recursos.

- **Equilibrio entre rendimiento y estabilidad:** Mejorar el rendimiento sin comprometer la estabilidad es un desafío central. La paralelización y la correcta gestión de dependencias reducen tiempos de ejecución, manteniendo la confiabilidad de la infraestructura.

- **Aprendizaje práctico para mejora continua:** Los ejemplos y recomendaciones permiten a los estudiantes comprender mejor Terraform, identificar cuellos de botella y optimizar procesos. Esto fomenta habilidades críticas y una mentalidad de mejora constante en la gestión de infraestructuras.