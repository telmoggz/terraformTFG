output "private_dns_zone_id" {
  value       = var.create_zone ? azurerm_private_dns_zone.private_dns_zone[0].id : null
  description = "The ID of the private DNS zone."
}

output "private_dns_zone_name" {
  value       = var.create_zone ? azurerm_private_dns_zone.private_dns_zone[0].name : null
  description = "The name of the private DNS zone."
}