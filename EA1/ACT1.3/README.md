# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# CREACIÓN DE DOCUMENTACIÓN DETALLADA PARA CADA COMPONENTE

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

### 5. Clonar el repositorio Github

1. Clona tu repositorio donde se aloja la actividad

Para mas detalles de como hacerlo, [GitHub Docs: Clone a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

2. Navegar a la Carpeta ACT1.2
```bash
cd AUY1105-Infraestructura-como-codigo-II/ACT1.3
```

3. Ejecutar el comando terraform-docs y Analizar Resultados
```bash
./terraform-docs markdown .
```

Analiza los resultados generados y revisa los resúmenes de configuraciones, variables y outputs.

### 6. Realiza modificaciones

1. Crea o modifica el archivo output.tf en tu repositorio siguiendo las instrucciones de [Terraform Docs: Output Values](https://developer.hashicorp.com/terraform/language/values/outputs)

```bash
output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ec2_instance.id
}
```

2. Crea o modifica el archivo variables.tf en tu fork siguiendo las instrucciones de [Terraform Docs: Input Values](https://developer.hashicorp.com/terraform/language/values/variables)

```bash
variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}
```

3. Ejecutar el comando terraform-docs y Analizar Resultados
```bash
./terraform-docs markdown .
```

4. Subir los Cambios a GitHub
```bash
git add .
git commit -m "Actualización de output.tf y variables.tf según TFLint"
git push origin main
```

El profesor revisará los resultados junto a los estudiantes y comentará sobre:

- **Importancia de terraform-docs:** cómo facilita la documentación automática de configuraciones de infraestructura.
- **Automatización y buenas prácticas:** la generación automática de documentación y la validación del código mejoran la eficiencia y la calidad del desarrollo.
- **Aprendizaje autónomo:** se destacará la importancia de aplicar cambios basados en recomendaciones de herramientas como TFLint para fortalecer la infraestructura como código.
