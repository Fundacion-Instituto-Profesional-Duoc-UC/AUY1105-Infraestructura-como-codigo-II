# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# PRUEBAS DE VALIDACIÓN DE CAMBIOS

## DESARROLLO DE ACTIVIDAD

### 1. Revisar el Pull Request (PR)

- Accede al [Pull Request](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II/pull/1).
- Examina el resultado del [Action](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II/actions/runs/12085036577/job/33701440564?pr=1) en el paso **Run TFLint**

### 2. Modificar el GitHub Action

1. Accede al archivo del workflow en el repositorio. Puede estar ubicado en .github/workflows/terraform.yml.

2. Edita el comando para cambiar el nivel mínimo de severidad de error a warning en el paso donde se ejecuta tflint.

```bash
      - name: Run TFLint
        working-directory: ${{ inputs.path }}
        run: tflint --minimum-failure-severity=error
```

```bash
      - name: Run TFLint
        working-directory: ${{ inputs.path }}
        run: tflint --minimum-failure-severity=warning
```

3. Guarda los cambios y asegúrate de hacer un commit en la rama correspondiente al PR.

4. Ejecutar el Action y Revisar Resultados

- Realiza un nuevo push en la rama del PR para que el workflow se ejecute nuevamente.
- Observa los resultados del Action:
Verifica si los warnings aparecen correctamente y si el flujo pasa sin fallar.
Asegúrate de que tflint ahora solo informe warnings en lugar de detenerse.

5. Corregir los warnings en los archivos Terraform

## REFLEXIONES

En esta actividad hemos explorado cómo los flujos de trabajo automatizados, como GitHub Actions, y las herramientas de análisis estático, como tflint, son esenciales para asegurar la calidad y seguridad en la infraestructura como código (IaC). Estos mecanismos automatizados no solo ayudan a identificar errores, sino que también fomentan las mejores prácticas y aseguran que el código cumpla con estándares establecidos.

Uno de los aprendizajes clave es la importancia de los warnings y errors en los procesos de validación. Aunque los warnings no bloqueen la ejecución, señalan áreas que podrían convertirse en problemas críticos si no se abordan. La automatización, como vimos, nos permite detectar problemas temprano y mantener un ciclo de desarrollo ágil, pero requiere disciplina para interpretar y actuar sobre los resultados.

Además, esta experiencia nos muestra cómo los pequeños detalles, como definir versiones de proveedores o la versión requerida de Terraform, pueden marcar una gran diferencia en la estabilidad del entorno. Esto subraya el valor de una mentalidad orientada a la mejora continua y la atención al detalle.

Finalmente, recordar que el uso de IaC y la automatización no es solo una cuestión técnica, sino también una oportunidad para desarrollar hábitos profesionales que aseguren calidad, eficiencia y colaboración efectiva en equipos. La capacidad de interpretar resultados, corregir y aprender continuamente es la clave del éxito en un entorno de infraestructura moderna.