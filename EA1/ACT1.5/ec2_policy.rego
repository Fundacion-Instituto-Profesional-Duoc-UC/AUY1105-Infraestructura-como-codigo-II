package terraform.ec2

# Por defecto, la política falla si no encuentra coincidencias
default allow = {
    "status": false,
    "reason": "No se encontró una instancia EC2 para evaluar o falló la validación."
}

# Regla 1: Permitir si es t2.micro
allow = {
    "status": true,
    "reason": "Cumple la política: La instancia es del tamaño permitido (t2.micro)."
} if {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_instance"
    resource.change.after.instance_type == "t2.micro"
}

# Regla 2: Denegar si NO es t2.micro
allow = {
    "status": false,
    "reason": "Violación de política: Solo se permite usar instancias t2.micro en el Learner Lab."
} if {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_instance"
    resource.change.after.instance_type != "t2.micro"
}