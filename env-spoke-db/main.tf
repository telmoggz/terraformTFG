# 1. Resource group
module "resource_group" {
  source   = "../modules/resource_group"
  rg_name  = var.resource_group_name
  location = var.location
}

# 2. Virtual network
module "virtual_network" {
  source              = "../modules/network"
  vnet_name           = var.virtual_network_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  address_space = ["10.1.0.0/16"]

  subnets = {
    "snet-postgres" = {
      address_prefixes = ["10.1.1.0/24"]
      delegation       = "Microsoft.DBforPostgreSQL/flexibleServers"
    }
  }
}

# 3. VNet Peering
module "vnet_peering" {
  source = "../modules/vnet_peering"

  local_rg_name   = module.resource_group.name
  local_vnet_id   = module.virtual_network.vnet_id
  local_vnet_name = module.virtual_network.vnet_name

  remote_vnet_id   = data.azurerm_virtual_network.hub_vnet.id
  remote_vnet_name = data.azurerm_virtual_network.hub_vnet.name
  remote_rg_name   = data.azurerm_virtual_network.hub_vnet.resource_group_name

  local_to_remote_peering_name = "spoke1-to-hub-peering"
  remote_to_local_peering_name = "hub-to-spoke1-peering"
}

# 4. Route table
module "route_table" {
  source              = "../modules/route_table"
  route_table_name    = "rt-spoke1-to-nva"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  routes = [
    {
      name                   = "Force-To-NVA"
      address_prefix         = "10.2.1.4"
      next_hop_type          = "VirtualNetworkAppliance"
      next_hop_in_ip_address = "10.0.1.4"
    }
  ]

  subnet_associations = ["snet-postgres"]

}

# 5. Private DNS Zone
module "private_dns_zone" {
  source              = "../modules/private_dns"
  create_zone         = false
  resource_group_name = var.hub_resource_group.name

  private_dns_zone_name = "privatelink.postgres.database.azure.com"

  vnet_links = {
    "spoke1-link" = {
      vnet_id              = module.virtual_network.vnet_id
      registration_enabled = false
    }
  }
}

# 6. Network Security Groups
module "nsg_postgres" {
  source              = "../modules/nsg"
  nsg_name            = "nsg-postgres"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.virtual_network.subnet_ids["snet-postgres"]

  security_rules = [
    {
      name                       = "Allow-PG-from-Jump"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefix      = var.jump_ip
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-PG-from-App2"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefix      = var.app2_ip
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-all-Inbound"
      priority                   = 1000
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-All-Outbound"
      priority                   = 1000
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    }
  ]
}

# 7. PostgreSQL Flexible Server
module "postgres" {
  source              = "../modules/postgresql"
  server_name         = var.postgres_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  delegated_subnet_id = module.virtual_network.subnet_ids["snet-postgres"]

  private_dns_zone_id = data.azurerm_private_dns_zone.hub_dns.id

  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  sku_name   = var.postgres_sku_name
  version    = var.postgres_version
  storage_mb = var.postgres_storage_mb

  backup_retention_days         = var.postgres_backup_retention_days
  geo_redundant_backup_enabled  = var.postgres_geo_redundant_backup_enabled
  active_directory_auth_enabled = var.postgres_active_directory_auth_enabled
  password_auth_enabled         = var.postgres_password_auth_enabled
  tenant_id                     = var.postgres_tenant_id

  db_name = var.postgres_db_name

}

# 8. Data sources for existing resources in the Hub
data "azurerm_private_dns_zone" "hub_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.hub_resource_group_name
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hubpro"
  resource_group_name = var.hub_resource_group_name
}