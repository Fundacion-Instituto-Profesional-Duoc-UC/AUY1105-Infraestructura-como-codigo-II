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

# 7. Instalar Go
echo "Instalando Go..."
GO_VERSION="1.21.0"
GO_URL="https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz"

curl -sSLo go.tar.gz "$GO_URL" || handle_error "7.1 (descarga de Go)"
sudo tar -C /usr/local -xzf go.tar.gz || handle_error "7.2 (extracción de Go)"
rm -f go.tar.gz || handle_error "7.3 (limpieza de archivo temporal)"

# Configurar el PATH para Go
if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc || handle_error "7.4 (configuración de PATH en ~/.bashrc)"
fi
export PATH=$PATH:/usr/local/go/bin

echo "Instalación de Go completada."

echo "Instalación completada con éxito."