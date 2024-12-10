# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# EJEMPLOS AVANZADOS DE IMPLEMENTACIÓN DEL MÓDULO

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
```

Ejecuta en el siguiente orden, los comandos en función de sus variables de entorno, definidas en archivos terminados en *.tfvars:

1. Ejecuta el que corresponde al ambiente de desarrollo:

```bash
terraform apply -var-file="dev.tfvars"
```

Una vez implementado, asegúrate de destruir los recursos

```bash
terraform destroy -var-file="dev.tfvars"
```

2. Ejecuta el que corresponde al ambiente de desarrollo:

```bash
terraform apply -var-file="qa.tfvars"
```

Una vez implementado, asegúrate de destruir los recursos

```bash
terraform destroy -var-file="qa.tfvars"
```

3. Ejecuta el que corresponde al ambiente de desarrollo:

```bash
terraform apply -var-file="prod.tfvars"
```

Una vez implementado, asegúrate de destruir los recursos

```bash
terraform destroy -var-file="prod.tfvars"
```

### 6. Integración de módulo con otros recursos

Revisa el contenido del archivo **load-balancer.tf**, y de que forma se incorporan dependencias con elementos que se generan en el módulo.

```bash
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.ec2.security_group_id]
  subnets            = [module.vpc.subnet_publica_1_id, module.vpc.subnet_publica_2_id]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}
```

## REFLEXIONES

- **Adaptación a diferentes escenarios:** Explorar configuraciones avanzadas y casos prácticos ayuda a los estudiantes a comprender cómo ajustar y personalizar los módulos para satisfacer las necesidades específicas de distintos entornos y servicios.

- **Gestión de dependencias y flexibilidad:** Implementar prácticas recomendadas para manejar dependencias permite crear módulos más robustos y flexibles, esenciales para entornos dinámicos y proyectos de gran escala.

- **Profundización en integración y escalabilidad:** La integración con otros servicios y la gestión de múltiples entornos refuerzan el entendimiento de cómo extender las capacidades de los módulos para construir infraestructuras más escalables y eficientes.