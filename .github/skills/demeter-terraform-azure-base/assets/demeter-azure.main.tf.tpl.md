module "vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "4.1.0"
  vnet_name           = "vnet-var.environment_name"
  resource_group_name = var.resource_group_name
  use_for_each        = true
  address_space       = ["10.0.0.0/16"]
}

module "aks" {
  source              = "Azure/aks/azurerm"
  version             = "7.3.1"
  resource_group_name = var.resource_group_name
  cluster_name        = "aks-var.environment_name"
  prefix              = "aks"
  vnet_subnet_id      = module.vnet.vnet_subnets[0]
  role_based_access_control_enabled = true
}
