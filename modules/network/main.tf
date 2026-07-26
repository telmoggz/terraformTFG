# This module creates an Azure Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

# This module creates an Azure Subnet
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = "delegation-${each.key}"

      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.service_actions
      }
    }
  }
}

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
