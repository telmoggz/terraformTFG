# Spoke Environment Terraform Variables
resource_group_name     = "rg-spokepro-01"
location                = "francecentral"
virtual_network_name    = "vnet-spokepro"
hub_resource_group_name = "rg-hubpro-01"

# Source and destination private IPs for NSG rules
jump_ip = "10.0.2.4"
app2_ip = "10.2.1.4"

# PostgreSQL Flexible Server Configuration
postgres_name           = "psql-tfg-pro-server"
postgres_admin_username = "tfgadmin"
postgres_admin_password = "TfgSecurePassword123!"


postgres_sku_name   = "B_Standard_B1ms"
postgres_version    = "14"
postgres_storage_mb = 32768

postgres_backup_retention_days         = 7
postgres_geo_redundant_backup_enabled  = false
postgres_active_directory_auth_enabled = false
postgres_password_auth_enabled         = true
postgres_tenant_id                     = "2d725577-c350-43a4-ab90-5334455d1fe3"
postgres_db_name                       = "tfgdb"