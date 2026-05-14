# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

<p align="left" style="text-align:left;">
  <a href="https://www.duoc.cl/">
    <img alt="Duoc UC" src="img/logo.png" width="1040"/>
  </a>
</p>

## Descripción

Repositorio del curso **AUY1105 - Infraestructura como Código II** de Duoc UC. Cubre prácticas avanzadas de IaC con Terraform en AWS, incluyendo calidad de código, módulos reutilizables, seguridad automatizada y gestión de estado.

## Requisitos

- Cuenta activa en [AWS Academy](https://awsacademy.instructure.com/) (Learner Lab)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado
- [Git](https://git-scm.com/) y cuenta en [GitHub](https://github.com/)
- Editor recomendado: Visual Studio Code con extensión Terraform

## Estructura del Repositorio

```
AUY1105/
├── EA1/   # Evaluación 1 — Calidad, seguridad y automatización
├── EA2/   # Evaluación 2 — Módulos Terraform reutilizables
├── EA3/   # Evaluación 3 — Gestión avanzada del estado
└── docs/  # Guía de contribuciones y código de conducta
```

---

## EA1 — Calidad, Seguridad y Automatización

| Actividad | Tema |
|-----------|------|
| [ACT1.1](EA1/ACT1.1/README.md) | Revisión de código mediante Pull Request |
| [ACT1.2](EA1/ACT1.2/README.md) | Uso de herramientas de análisis estático (TFLint) |
| [ACT1.3](EA1/ACT1.3/README.md) | Creación de documentación detallada (terraform-docs) |
| [ACT1.4](EA1/ACT1.4/README.md) | Registro de cambios y versionado (CHANGELOG + Releases) |
| [ACT1.5](EA1/ACT1.5/README.md) | Creación de políticas básicas de seguridad (OPA) |
| [ACT1.6](EA1/ACT1.6/README.md) | Herramientas de cumplimiento de seguridad (Checkov) |
| [ACT1.7](EA1/ACT1.7/README.md) | Pruebas de validación de cambios (GitHub Actions + TFLint) |
| [ACT1.8](EA1/ACT1.8/README.md) | Revisión de conformidad con auditoría automatizada (GitHub Actions + Checkov) |

---

## EA2 — Módulos Terraform Reutilizables

| Actividad | Tema |
|-----------|------|
| [ACT2.1](EA2/ACT2.1/README.md) | Estructuración de un módulo básico de Terraform |
| [ACT2.2](EA2/ACT2.2/README.md) | Implementación de variables y parámetros en el módulo |
| [ACT2.3](EA2/ACT2.3/README.md) | Creación de una guía de uso para el módulo (terraform-docs) |
| [ACT2.4](EA2/ACT2.4/README.md) | Ejemplos avanzados: múltiples ambientes (dev/qa/prod) con tfvars |
| [ACT2.5](EA2/ACT2.5/README.md) | Uso de versionado semántico de un módulo (GitHub Releases) |
| [ACT2.6](EA2/ACT2.6/README.md) | Actualización mayor (MAJOR) con compatibilidad hacia atrás |
| [ACT2.7](EA2/ACT2.7/README.md) | Pruebas de compatibilidad y documentación de resultados |
| [ACT2.8](EA2/ACT2.8/README.md) | Implementación de cambios con documentación de migración |

---

## EA3 — Gestión Avanzada del Estado

| Actividad | Tema |
|-----------|------|
| [ACT3.1](EA3/ACT3.1/README.md) | Manipulación de archivos de estado en Terraform |
| [ACT3.2](EA3/ACT3.2/README.md) | Recuperación de estado y manejo de errores |
| [ACT3.3](EA3/ACT3.3/README.md) | Simplificación de configuraciones |
| [ACT3.4](EA3/ACT3.4/README.md) | Implementación de eficiencia en la configuración |
| [ACT3.5](EA3/ACT3.5/README.md) | Gestión del estado con comandos avanzados |
| [ACT3.6](EA3/ACT3.6/README.md) | Migración y modificación del estado |

---

## Contribuciones

Contribuciones son bienvenidas! Revisa nuestra [Guía de Contribuciones](./docs/contributors.md)

## Código de Conducta

Por favor, contribuye con amabilidad. Revisa nuestro [Código de Conducta](./docs/CODE_OF_CONDUCT.md)
