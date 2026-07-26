# This module creates an Azure Virtual Network Peering from Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                 = var.hub_to_spoke_peering_name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  remote_virtual_network_id = var.spoke_vnet_id

  allow_forwarded_traffic      = var.forwarded_traffic
  allow_virtual_network_access = var.virtual_network_access
}

# This module creates an Azure Virtual Network Peering from Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                 = var.spoke_to_hub_peering_name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  remote_virtual_network_id = var.hub_vnet_id

  allow_forwarded_traffic      = var.forwarded_traffic
  allow_virtual_network_access = var.virtual_network_access
}