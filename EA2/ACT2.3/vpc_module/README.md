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
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_assoc_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_assoc_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_assoc_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_assoc_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.subnet_privada_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_privada_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_publica_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_publica_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.mi_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_1"></a> [az\_1](#input\_az\_1) | Zona de disponibilidad para la Subnet 1 | `string` | `"us-east-1a"` | no |
| <a name="input_az_2"></a> [az\_2](#input\_az\_2) | Zona de disponibilidad para la Subnet 2 | `string` | `"us-east-1b"` | no |
| <a name="input_subnet_privada_1_cidr"></a> [subnet\_privada\_1\_cidr](#input\_subnet\_privada\_1\_cidr) | CIDR block de la Subnet privada 1 | `string` | `"10.0.3.0/24"` | no |
| <a name="input_subnet_privada_2_cidr"></a> [subnet\_privada\_2\_cidr](#input\_subnet\_privada\_2\_cidr) | CIDR block de la Subnet privada 2 | `string` | `"10.0.4.0/24"` | no |
| <a name="input_subnet_publica_1_cidr"></a> [subnet\_publica\_1\_cidr](#input\_subnet\_publica\_1\_cidr) | CIDR block de la Subnet pública 1 | `string` | `"10.0.1.0/24"` | no |
| <a name="input_subnet_publica_2_cidr"></a> [subnet\_publica\_2\_cidr](#input\_subnet\_publica\_2\_cidr) | CIDR block de la Subnet pública 2 | `string` | `"10.0.2.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block de la VPC | `string` | `"10.1.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Nombre de la VPC | `string` | `"mi-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | Internet Gateway ID |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | NAT Gateway ID |
| <a name="output_subnet_privada_1_id"></a> [subnet\_privada\_1\_id](#output\_subnet\_privada\_1\_id) | ID de la Subnet privada 1 |
| <a name="output_subnet_privada_2_id"></a> [subnet\_privada\_2\_id](#output\_subnet\_privada\_2\_id) | ID de la Subnet privada 2 |
| <a name="output_subnet_publica_1_id"></a> [subnet\_publica\_1\_id](#output\_subnet\_publica\_1\_id) | ID de la Subnet pública 1 |
| <a name="output_subnet_publica_2_id"></a> [subnet\_publica\_2\_id](#output\_subnet\_publica\_2\_id) | ID de la Subnet pública 2 |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID de la VPC creada |
