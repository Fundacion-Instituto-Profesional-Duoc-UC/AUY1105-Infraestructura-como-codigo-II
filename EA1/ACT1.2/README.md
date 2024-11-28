# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# USO DE HERRAMIENTAS DE ANÁLISIS ESTÁTICO

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

1. Clona el repositorio proporcionado:
```bash
git clone https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II.git
```

Para mas detalles de como hacerlo, [GitHub Docs: Clone a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

2. Navegar a la Carpeta ACT1.2
```bash
cd AUY1105-Infraestructura-como-codigo-II/ACT1.2
```

3. Ejecutar TFLint y Analizar Resultados
```bash
tflint
```
Revisa los mensajes de advertencia y error generados por la herramienta. Analiza los resultados y toma nota de las mejoras sugeridas.

### Reflexión

- Importancia de TFLint: cómo ayuda a identificar problemas en configuraciones de Terraform antes de aplicarlas.
- Ventajas de la automatización: se discutirá la relevancia de automatizar análisis estáticos para reducir errores y mejorar la calidad del código.
- Aprendizaje autónomo: se fomentará la práctica de mejora continua mediante la aplicación de sugerencias en forks propios.


