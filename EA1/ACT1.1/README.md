# AUY1105 - Infraestructura como código II

# Revisión de código mediante pull requests

## DESARROLLO DE ACTIVIDAD

### 1. Realizar un Fork del Repositorio

1. Accede al repositorio de GitHub proporcionado: [AUY1105-Infraestructura-como-codigo-II](https://github.com/Fundacion-Instituto-Profesional-Duoc-UC/AUY1105-Infraestructura-como-codigo-II).  
2. Haz clic en el botón **Fork** en la parte superior derecha de la página.  
3. Selecciona tu cuenta de GitHub como destino del fork.

Para más detalles sobre cómo hacer un fork, consulta la guía oficial de GitHub:  
[GitHub Docs: Fork a Repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

### 2. Clonar el Repositorio Forkeado en Tu Máquina Local

Ejecuta el siguiente comando en tu terminal para clonar tu fork:

```bash
git clone https://github.com/tu-usuario/AUY1105-Infraestructura-como-codigo-II.git
```

### 3. Revisar el Código y Realizar un Cambio Pequeño

- Navega al directorio del proyecto:
```bash
cd AUY1105-Infraestructura-como-codigo-II
```
- Abre el proyecto en tu editor de código preferido (por ejemplo, VS Code):
```bash
code .
```
- Realiza un cambio pequeño, como corregir un comentario, actualizar documentación o modificar una línea de código simple.
- Guarda los cambios y ejecuta los siguientes comandos para hacer commit y subir los cambios:
```bash
git add .
git commit -m "Pequeño cambio sugerido"
git push origin main
```
### 4. Crear un Pull Request

- Accede a tu repositorio forkeado en GitHub.
- Haz clic en el botón Compare & pull request.
- Escribe un mensaje claro describiendo los cambios realizados y por qué son útiles.
- Haz clic en Create pull request.

[GitHub Docs: Create a Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).