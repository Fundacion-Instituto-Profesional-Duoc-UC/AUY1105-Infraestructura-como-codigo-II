# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# REVISIÓN DE CONFORMIDAD CON AUDITORÍA AUTOMATIZADA  

## DESARROLLO DE ACTIVIDAD

### 1. Revisar el Pull Request (PR)

- Accede al [Pull Request](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II/pull/2).
- Examina el resultado del [Action](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II/actions/runs/12086934336/job/33707311144) en el paso **Run Checkov for Security Analysis**

### 2. Modificar el GitHub Action

1. Accede al archivo del workflow en el repositorio. Puede estar ubicado en .github/workflows/checkov.yml.

2. Edita el comando para cambiar el nivel mínimo de severidad de error a warning en el paso donde se ejecuta tflint.

```bash
      - name: Run Checkov on Terraform files
        run: |
          checkov -d ${{ inputs.path }}
```

```bash
      - name: Run Checkov on Terraform files
        run: |
          checkov -d ${{ inputs.path }} --soft-fail
```

3. Guarda los cambios y asegúrate de hacer un commit en la rama correspondiente al PR.

4. Ejecutar el Action y Revisar Resultados

- Realiza un nuevo push en la rama del PR para que el workflow se ejecute nuevamente.
- Observa los resultados del Action:
Verifica si los warnings aparecen correctamente y si el flujo pasa sin fallar.
Asegúrate de que checkov ahora solo informe warnings en lugar de detenerse.

5. Corregir los warnings en los archivos Terraform

## REFLEXIONES

- Automatización en la Seguridad de IaC: El uso de herramientas como Checkov nos permite detectar problemas de seguridad de manera temprana y en tiempo real, antes de que el código se despliegue en producción. Esto refleja la importancia de integrar auditorías de seguridad dentro del ciclo de vida del desarrollo.
En la actividad, al modificar el nivel de severidad de los errores a "warning", se proporciona una solución que no interrumpe el flujo de trabajo, lo cual es crucial cuando se manejan proyectos de infraestructura que deben ser continuos y sin demoras. Al mantener el flujo de trabajo activo a pesar de las advertencias, se obtiene una ventaja en cuanto a la flexibilidad sin comprometer la visibilidad de los problemas.

- Detección Temprana de Vulnerabilidades: Detectar problemas de seguridad en los archivos de Terraform con herramientas automatizadas ayuda a evitar errores costosos y potenciales brechas de seguridad en el futuro. Aunque Checkov solo marca advertencias en lugar de errores (con el uso de --soft-fail), sigue proporcionando visibilidad sobre configuraciones incorrectas o inseguras que deben corregirse.
Este enfoque también resalta la importancia de tener configuraciones de infraestructura que no solo funcionen, sino que sean seguras y escalables a largo plazo.
