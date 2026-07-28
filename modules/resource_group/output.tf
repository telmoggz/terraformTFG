output "name" {
  value       = azurerm_resource_group.resource_group.name
  description = "The name of the resource group."
}

output "id" {
  value       = azurerm_resource_group.resource_group.id
  description = "The ID of the resource group."
}

output "location" {
  value       = azurerm_resource_group.resource_group.location
  description = "The location of the resource group."
}