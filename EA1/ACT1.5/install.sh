#!/bin/bash

# Función para manejar errores
handle_error() {
    echo "Error: Falló la instalación en el paso $1."
    exit 1
}

# Definir versiones y URLs
TERRAFORM_DOCS_VERSION="v0.19.0"
TERRAFORM_DOCS_URL="https://terraform-docs.io/dl/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64.tar.gz"
OPA_URL="https://openpolicyagent.org/downloads/latest/opa_linux_amd64"

echo "Iniciando instalación de herramientas..."

# 1. Instalar pip para Python 3
echo "Instalando pip para Python 3..."
sudo yum install -y python3-pip || handle_error "1 (sudo yum install -y python3-pip)"

# 2. Instalar Checkov usando pip
echo "Instalando Checkov..."
pip3 install checkov || handle_error "2 (pip3 install checkov)"

# 3. Instalar yum-utils
echo "Instalando yum-utils..."
sudo yum install -y yum-utils || handle_error "3 (sudo yum install -y yum-utils)"

# 4. Agregar el repositorio de HashiCorp
echo "Agregando el repositorio de HashiCorp..."
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo || handle_error "4 (sudo yum-config-manager --add-repo)"

# 5. Instalar Terraform
echo "Instalando Terraform..."
sudo yum -y install terraform || handle_error "5 (sudo yum install terraform)"

# 6. Instalar Terraform-Docs
echo "Instalando Terraform-Docs..."
curl -sSLo terraform-docs.tar.gz "$TERRAFORM_DOCS_URL" || handle_error "6.1 (descarga de terraform-docs)"
tar -xzf terraform-docs.tar.gz || handle_error "6.2 (extracción de terraform-docs)"
chmod +x terraform-docs || handle_error "6.3 (asignar permisos a terraform-docs)"
sudo mv terraform-docs /usr/local/bin/ || handle_error "6.4 (mover terraform-docs a /usr/local/bin)"
rm -rf terraform-docs.tar.gz README.md LICENSE || handle_error "6.5 (limpieza de archivos temporales)"

# 7. Instalar OPA
echo "Instalando OPA..."
curl -L -o opa "$OPA_URL" || handle_error "7.1 (descarga de OPA)"
chmod +x opa || handle_error "7.2 (asignar permisos a OPA)"
sudo mv opa /usr/local/bin/ || handle_error "7.3 (mover OPA a /usr/local/bin)"

echo "Instalación completada con éxito."