package terraform.security

# Definir una lista de claves SSH permitidas
allowed_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiuFUssdtHg8Y3rWGZFCSD58hSr4IqjFVKeid9d0G3bk7w99/AOyL/C45PnFodjOtD1eMndiCd40BqagdOYtKoieqlOTlmShrvE7N2A+MeaOP4CWLx7fj2MfekecPPFRAiMUCZk51SHxFr4oqX4Qhj8BkG1cG30p9QB+stfJKT3tUGczxUB1aor9qoLmPDTfaE4iSmNDscVmqQhX9jkppdzkg2ENh5cDO2EtLlHHxIodXLgetpWjBP68r90q/gwZV69XANcTWjZiZRyDmb9nIfQiZOO5C03FoG0GmTSZkAfvZdq7M2GsQSboln44VW/ukyQKFRVVepOCIHTaqcsjhV"
]

# Verificar si la clave SSH es válida
valid_key(public_key) {
    public_key == allowed_keys[_]
}

# Reglas para verificar el acceso SSH
deny_ssh_access {
    input.resource_type == "aws_security_group"
    input.resource.ingress[_].from_port == 53
    input.resource.ingress[_].to_port == 53
    input.resource.ingress[_].cidr_blocks == ["0.0.0.0/0"]
}

# Validar clave SSH en el recurso aws_key_pair
deny_invalid_key {
    input.resource_type == "aws_key_pair"
    not valid_key(input.resource.public_key)
}

# Acciones para aplicar las reglas
deny {
    deny_ssh_access
}

deny {
    deny_invalid_key
}
