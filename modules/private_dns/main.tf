# This module creates an Azure Private DNS Zone
resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.create_zone ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

# This module creates a link between the Private DNS Zone and a Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = var.vnet_links

  name                  = "link-${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.create_zone ? azurerm_private_dns_zone.private_dns_zone[0].name : var.private_dns_zone_name
  virtual_network_id    = each.value.vnet_id

  registration_enabled = each.value.registration_enabled

}