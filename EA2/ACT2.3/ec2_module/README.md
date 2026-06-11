## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.mi_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.mi_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.ssh_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | ID de la AMI para la instancia EC2 | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Nombre de la instancia EC2 | `string` | `"MiInstancia"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Tipo de instancia EC2 | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Nombre del par de claves | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Clave pública SSH | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Nombre del grupo de seguridad | `string` | `"ssh-access"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID de la subred donde se creará la instancia | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID de la VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID de la instancia EC2 |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | IP pública de la instancia EC2 |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID del grupo de seguridad |
