output "server_id" {
  description = "The ID of the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.id
}

output "server_name" {
  description = "The name of the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.name
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.postgresql_server.fqdn
}
