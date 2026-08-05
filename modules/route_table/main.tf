#This module creates an Azure Route Table
resource "azurerm_route_table" "route_table" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# This resource creates a time delay to ensure that the route table is fully provisioned before creating routes
resource "time_sleep" "wait_for_subnets" {
  depends_on      = [azurerm_route_table.route_table]
  create_duration = "30s"
}

# This module creates routes in the Azure Route Table
resource "azurerm_route" "route" {
  for_each = var.routes

  name                = each.key
  resource_group_name = azurerm_route_table.route_table.resource_group_name
  route_table_name    = azurerm_route_table.route_table.name
  address_prefix      = each.value.address_prefix
  next_hop_type       = each.value.next_hop_type

  next_hop_in_ip_address = each.value.next_hop_type == "VirtualAppliance" ? each.value.next_hop_in_ip_address : null

}

# This module associates the Azure Route Table with subnets
resource "azurerm_subnet_route_table_association" "subnet_association" {
  for_each = var.subnet_associations

  subnet_id      = each.value.subnet_id
  route_table_id = azurerm_route_table.route_table.id
}