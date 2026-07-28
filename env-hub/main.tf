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

  address_space = ["10.0.0.0/16"]

  subnets = {
    "snet-nva" = {
      address_prefixes = ["10.0.1.0/24"]
      delegation       = null
    }
    "snet-jump" = {
      address_prefixes = ["10.0.2.0/24"]
      delegation       = null
    }
  }
}

module "private_dns_zone" {
  source              = "../modules/private_dns"
  resource_group_name = module.resource_group.name

  private_dns_zone_name = "privatelink.postgres.database.azure.com"

  vnet_links = {
    "hub-link" = {
      vnet_id              = module.virtual_network.vnet_id
      registration_enabled = false
    }
  }
}

module "nsg_jump" {
  source              = "../modules/nsg"
  nsg_name            = "nsg-jump"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.virtual_network.subnet_ids["snet-jump"]

  security_rules = [
    {
      name                       = "Allow-SSH-Inbound-Admin"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = var.public_ip_address
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
      name                       = "Allow-PostgresSQL-Outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefix      = var.jump_ip
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

module "nsg_nva" {
  source              = "../modules/nsg"
  nsg_name            = "nsg-nva"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.virtual_network.subnet_ids["snet-nva"]

  security_rules = [
    {
      name                       = "Allow-Internal-Inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
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
      name                       = "Allow-Internal-Outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
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

module "jump_vm" {
  source              = "../modules/vm-linux"
  vm_name             = var.jump_vm_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id = module.virtual_network.subnet_ids["snet-jump"]

  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path

  size             = var.jump_vm_size
  create_public_ip = true

  os_disk_caching      = var.jump_os_disk_caching
  storage_account_type = var.jump_storage_account_type

  image_publisher = var.jump_image_publisher
  image_offer     = var.jump_image_offer
  image_sku       = var.jump_image_sku
  image_version   = var.jump_image_version

}

module "nva_vm" {
  source              = "../modules/vm-linux"
  vm_name             = var.nva_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id = module.virtual_network.subnet_ids["snet-nva"]

  os_disk_caching      = var.nva_os_disk_caching
  storage_account_type = var.nva_storage_account_type

  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path

  size             = var.nva_size
  create_public_ip = false

  image_publisher = var.nva_image_publisher
  image_offer     = var.nva_image_offer
  image_sku       = var.nva_image_sku
  image_version   = var.nva_image_version

}