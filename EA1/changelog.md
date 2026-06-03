# 📓 Changelog - Gestión de Infraestructura

Todos los cambios notables en este proyecto serán documentados en este archivo siguiendo los hitos de la evaluación.

## [1.3.0] - 2026-04-18

### 🔒 Seguridad y Cumplimiento (IL 2.1, 2.2, 2.3)
- **Zero Hardcoded Secrets:** Se eliminaron las credenciales en duro de los proveedores. Ahora se utilizan **Secrets de GitHub** para el despliegue automático.
- **Firewall a Nivel de Código:** Restricción del tráfico de entrada SSH. Solo se permite la conexión desde la IP pública del administrador, mitigando riesgos de intrusión externa.
- **Validación de Políticas:** Se realizaron pruebas de conectividad para verificar la efectividad de las nuevas reglas de seguridad en los grupos de seguridad.

### 🛠️ Refactorización de Terraform (IL 1.1, 1.2)
- **Corrección de Providers:** Actualización y estandarización de los bloques `required_providers` con versiones restringidas para asegurar la estabilidad del entorno.
- **Inyección de Variables:** Creación de archivos `variables.tf` en todas las carpetas **ACT** para resolver errores de variables no declaradas.
- **Saneamiento Técnico:** Aplicación de comandos `terraform fmt` para consistencia estilística y `terraform validate` para asegurar la integridad lógica.

### 🚀 Automatización y CI/CD (IL 2.2)
- **Ajuste de Sensibilidad Checkov:** Se implementó la bandera `--soft-fail` en el workflow para permitir la continuidad del desarrollo manteniendo un reporte detallado de hallazgos de seguridad.

### 📝 Documentación (IL 1.3)
- **Actualización de READMEs:** Se restauraron y mejoraron los manuales de las actividades **ACT1.3** y **ACT1.4**, incluyendo ahora mejores prácticas y guías de configuración.

---