#!/bin/bash

# Función para manejar errores
handle_error() {
    echo "Error: Falló la instalación en el paso $1."
    exit 1
}

echo "Iniciando instalación de herramientas..."

# 1. Instalar pip para Python 3
echo "Instalando pip para Python 3..."
sudo yum install -y python3-pip || handle_error "1 (sudo yum install -y python3-pip)"

# 2. Instalar Checkov usando pip
echo "Instalando Checkov..."
pip3 install checkov || handle_error "2 (pip3 install checkov)"

# 3. Instalar yum-utils
echo "Instalando yum-utils..."
sudo yum install -y yum-utils || handle_error "3 (yum install yum-utils)"

# 4. Agregar el repositorio de HashiCorp
echo "Agregando el repositorio de HashiCorp..."
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo || handle_error "4 (yum-config-manager --add-repo)"

# 5. Instalar Terraform
echo "Instalando Terraform..."
sudo yum -y install terraform || handle_error "5 (yum install terraform)"

# 6. Instalar Terraform-Docs
echo "Instalando Terraform-Docs..."
TERRAFORM_DOCS_VERSION="v0.19.0"
TERRAFORM_DOCS_URL="https://terraform-docs.io/dl/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64.tar.gz"

curl -sSLo terraform-docs.tar.gz "$TERRAFORM_DOCS_URL" || handle_error "6.1 (descarga de terraform-docs)"
tar -xzf terraform-docs.tar.gz || handle_error "6.2 (extracción de terraform-docs)"
chmod +x terraform-docs || handle_error "6.3 (asignar permisos a terraform-docs)"
sudo mv terraform-docs /usr/local/bin/ || handle_error "6.4 (mover terraform-docs a /usr/local/bin)"
rm -rf terraform-docs.tar.gz README.md LICENSE || handle_error "6.5 (limpieza de archivos temporales)"

echo "Instalación completada con éxito."