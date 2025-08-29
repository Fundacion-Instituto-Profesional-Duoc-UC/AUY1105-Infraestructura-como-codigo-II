module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.10.0"

  address_space       = [var.network_block]
  location            = var.location
  name                = "${local.resource_prefix}-vnet"
  resource_group_name = var.resource_group_name
  subnets             = var.subnets
}
