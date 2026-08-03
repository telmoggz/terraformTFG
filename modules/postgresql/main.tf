# This module creates an Azure PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.postgres_version

  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_id


  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb

  public_network_access_enabled = var.public_network_access_enabled

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone,
      authentication[0].tenant_id
    ]
  }

  authentication {
    active_directory_auth_enabled = var.active_directory_auth_enabled
    password_auth_enabled         = var.password_auth_enabled
    tenant_id                     = var.tenant_id
  }

}

# This module creates a PostgreSQL Flexible Server database
resource "azurerm_postgresql_flexible_server_database" "db" {
  count     = var.db_name != null ? 1 : 0
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
