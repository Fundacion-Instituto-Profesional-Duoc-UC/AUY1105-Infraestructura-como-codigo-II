package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEC2Infrastructure(t *testing.T) {
	t.Parallel()

	// Apunta al directorio donde está el código de Terraform de tu módulo EC2
	exampleDir := "../ec2_module"

	// Configura las opciones de Terraform con tus datos reales
	terraformOptions := &terraform.Options{
		TerraformDir: exampleDir,
		NoColor:      true,

		Vars: map[string]interface{}{
			"instance_name":       "ServidorTest",
			"instance_type":       "t2.micro",
			"ami":                 "ami-0c7217cdde317cfec", 
			"key_name":            "clave-test-terratest",
			
			// Clave SSH válida generada para la prueba
			"public_key":          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrX0gN+vV6xXh+nC8T5m0K6R8B3sD5uY4L9c+8sB2D5e5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5m5v5kL5 dummy@test", 
			
			"use_security_group":  true,
			"security_group_name": "sg-prueba-terratest",

			// Tus datos reales de red en AWS
			"vpc_id":              "vpc-0681426a108314c6a", 
			"subnet_id":           "subnet-00e424e5a8f3ad4c4", 
		},
	}

	// Limpia el estado de Terraform después de que termine el test
	defer terraform.Destroy(t, terraformOptions)

	// Inicializa y aplica el código de Terraform
	terraform.InitAndApply(t, terraformOptions)

	// --- ASERCIONES (Validaciones) ---

	// 1. Verifica que el ID de la instancia exista
	instanceID := terraform.Output(t, terraformOptions, "instance_id")
	assert.NotEmpty(t, instanceID)

	// 2. Verifica que se haya asignado una IP pública a la instancia
	publicIP := terraform.Output(t, terraformOptions, "public_ip")
	assert.NotEmpty(t, publicIP)

	// 3. Verifica que el Grupo de Seguridad se haya creado y devuelto su ID
	securityGroupID := terraform.Output(t, terraformOptions, "security_group_id")
	assert.NotEmpty(t, securityGroupID)
}