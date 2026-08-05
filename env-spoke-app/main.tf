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

  address_space = ["10.2.0.0/16"]

  subnets = {
    "snet-cmp" = {
      address_prefixes = ["10.2.1.0/24"]
      delegation       = null
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

  local_to_remote_peering_name = "spoke2-to-hub-peering"
  remote_to_local_peering_name = "hub-to-spoke2-peering"
}

# 4. Route table
module "route_table" {
  source              = "../modules/route_table"
  route_table_name    = "rt-spoke2-to-nva"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  routes = {
    "Force-To-NVA" = {
      address_prefix         = "10.1.1.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.1.4"
    }
  }

  subnet_associations = {
    "assoc-cmp" = {
      subnet_id = module.virtual_network.subnet_ids["snet-cmp"]
    }
  }

}

# 5. Private DNS Zone
module "private_dns_zone" {
  source              = "../modules/private_dns"
  create_zone         = false
  resource_group_name = var.hub_resource_group_name

  private_dns_zone_name = "privatelink.postgres.database.azure.com"

  vnet_links = {
    "spoke2-link" = {
      vnet_id              = module.virtual_network.vnet_id
      registration_enabled = false
    }
  }
}

# 6. Network Security Groups
module "nsg_cmp" {
  source              = "../modules/nsg"
  nsg_name            = "nsg-cmp"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.virtual_network.subnet_ids["snet-cmp"]

  security_rules = [
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
      name                       = "Allow-PostgreSQL-Outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefix      = var.app2_ip
      destination_address_prefix = var.postgresql_ip
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


# 7. Virtual Machine
module "cmp_vm" {
  source              = "../modules/vm-linux"
  vm_name             = var.cmp_vm_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id = module.virtual_network.subnet_ids["snet-cmp"]

  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path

  size             = var.cmp_vm_size
  create_public_ip = false

  os_disk_caching      = var.cmp_os_disk_caching
  storage_account_type = var.cmp_storage_account_type

  image_publisher = var.cmp_image_publisher
  image_offer     = var.cmp_image_offer
  image_sku       = var.cmp_image_sku
  image_version   = var.cmp_image_version

}

# 8. Data sources for existing resources in the Hub
data "azurerm_private_dns_zone" "hub_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.hub_resource_group_name
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hubpro" # Nombre exacto que le diste a la VNet del Hub
  resource_group_name = var.hub_resource_group_name
}