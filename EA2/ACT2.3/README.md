# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# CREACIÓN DE UNA GUÍA DE USO PARA EL MODULO

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

Ejecuta los siguientes comandso para generar la documentación de Terraform asociada a los módulos:

```bash
terraform-docs markdown ec2_module > ec2_module/README.md
terraform-docs markdown vpc_module > vpc_module/README.md
```

Agrega en el archivo de **vpc_module/outputs.tf** los siguientes parámetros de salida:

```bash
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.nat_gw.id
}
```

Ejecuta nuevamente el comando de terraform-docs asociado a la VPC para ver los resultados

```bash
terraform-docs markdown vpc_module > vpc_module/README.md
```

## REFLEXIONES

- **Claridad y accesibilidad de la documentación:** Una guía bien estructurada y detallada facilita que los usuarios comprendan las variables, salidas y configuraciones del módulo, asegurando una implementación eficiente y reduciendo la necesidad de soporte adicional.

- **Ejemplos prácticos y recomendaciones:** Incluir ejemplos claros de uso y mejores prácticas ayuda a los usuarios a aplicar el módulo correctamente en distintos entornos, promoviendo consistencia y reduciendo errores en la implementación.

- **Mejora de la colaboración y reutilización:** Documentar de manera exhaustiva las funcionalidades y parámetros del módulo fomenta la reutilización y la colaboración entre equipos, garantizando una gestión más eficiente y estandarizada de la infraestructura como código.