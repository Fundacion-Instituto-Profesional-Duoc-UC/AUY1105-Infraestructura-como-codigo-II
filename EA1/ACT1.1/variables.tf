variable "project_name" {
  type        = string
  description = "The name of the project, used for naming resources"
  default     = "clase-5"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "East US 2"
}

variable "network_block" {
  type        = string
  description = "The network block for the virtual network (e.g., 10.0.0.0/16)"
  default     = "10.0.0.0/16"
}

variable "resource_group_name" {
  type        = string
  description = "Name of new or existing resource group to use (required if create_resource_group is false)"
  default     = "AreaInfraestructura"
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
    "subnet2" = {
      name             = "subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}
