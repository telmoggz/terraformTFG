# This module creates an Azure Virtual Network Peering from Hub to Spoke
resource "azurerm_virtual_network_peering" "local_to_remote" {
  name                      = var.local_to_remote_peering_name
  resource_group_name       = var.local_rg_name
  virtual_network_name      = var.local_vnet_name
  remote_virtual_network_id = var.remote_vnet_id

  allow_forwarded_traffic      = var.forwarded_traffic
  allow_virtual_network_access = var.virtual_network_access
}

# This module creates an Azure Virtual Network Peering from Spoke to Hub
resource "azurerm_virtual_network_peering" "remote_to_local" {
  name                      = var.remote_to_local_peering_name
  resource_group_name       = var.remote_rg_name
  virtual_network_name      = var.remote_vnet_name
  remote_virtual_network_id = var.local_vnet_id

  allow_forwarded_traffic      = var.forwarded_traffic
  allow_virtual_network_access = var.virtual_network_access
}