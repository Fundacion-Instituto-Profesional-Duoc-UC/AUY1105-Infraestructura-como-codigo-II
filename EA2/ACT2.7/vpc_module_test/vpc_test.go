package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVPCInfrastructure(t *testing.T) {
	t.Parallel()

	// Obtén el directorio donde se encuentra el código de Terraform
	exampleDir := "../vpc_module"

	// Inicializa el módulo de Terraform
	terraformOptions := &terraform.Options{
		// Dirigirse a la carpeta que contiene los archivos de terraform
		TerraformDir: exampleDir,

		// No generar el archivo de estado
		NoColor: true,

		// Configura variables de entrada si es necesario (puedes añadir más según sea necesario)
		Vars: map[string]interface{}{
			"vpc_name":              "mi_vpc",
			"vpc_cidr":              "10.0.0.0/16",
			"subnet_publica_1_cidr": "10.0.1.0/24",
			"subnet_publica_2_cidr": "10.0.2.0/24",
			"subnet_privada_1_cidr": "10.0.3.0/24",
			"subnet_privada_2_cidr": "10.0.4.0/24",
			"az_1":                  "us-east-1a",
			"az_2":                  "us-east-1b",
		},

		// Configurar variables de entorno si es necesario (por ejemplo, AWS Access Key)
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},

		// Configurar variables de backend si es necesario
	}

	// Limpia el estado de Terraform después de que termine el test
	defer terraform.Destroy(t, terraformOptions)

	// Inicializa y aplica el código de Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Verifica que la VPC haya sido creada correctamente
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcID)

	// Verifica que el Internet Gateway haya sido creado correctamente
	igwID := terraform.Output(t, terraformOptions, "internet_gateway_id")
	assert.NotEmpty(t, igwID)

	// Verifica que las subnets públicas y privadas estén creadas
	publicSubnet1ID := terraform.Output(t, terraformOptions, "subnet_publica_1_id")
	assert.NotEmpty(t, publicSubnet1ID)

	publicSubnet2ID := terraform.Output(t, terraformOptions, "subnet_publica_2_id")
	assert.NotEmpty(t, publicSubnet2ID)

	privateSubnet1ID := terraform.Output(t, terraformOptions, "subnet_privada_1_id")
	assert.NotEmpty(t, privateSubnet1ID)

	privateSubnet2ID := terraform.Output(t, terraformOptions, "subnet_privada_2_id")
	assert.NotEmpty(t, privateSubnet2ID)

	// Verifica que el NAT Gateway haya sido creado correctamente
	natGatewayID := terraform.Output(t, terraformOptions, "nat_gateway_id")
	assert.NotEmpty(t, natGatewayID)
}
