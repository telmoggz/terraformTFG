resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.version

  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id     = var.private_dns_zone_id


  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name               = var.sku_name
  storage_mb             = var.storage_mb

  backup_retention_days  = var.backup_retention_days
  geo_redundant_backup_enabled   = var.geo_redundant_backup_enabled

  authentication {
    active_directory_auth_enabled = var.active_directory_auth_enabled
    password_auth_enabled = var.password_auth_enabled
    tenant_id              = var.tenant_id
  }

}
