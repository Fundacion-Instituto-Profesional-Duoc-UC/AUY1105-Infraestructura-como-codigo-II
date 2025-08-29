module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.18.1"

  name                       = "${local.resource_prefix}-vm"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  zone                       = 1
  encryption_at_host_enabled = false

  os_type  = "Linux"
  sku_size = "Standard_DS1_v2"

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interfaces = {
    network_interface_1 = {
      name = "${local.resource_prefix}-nic"
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "${local.resource_prefix}-nic"
          private_ip_subnet_resource_id = module.virtual_network.subnets["subnet1"].resource_id
        }
      }
    }
  }
}