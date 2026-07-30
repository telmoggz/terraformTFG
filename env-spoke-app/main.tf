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


module "nsg_jump" {
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
    name                       = "Allow-PostgresSQL-Outbound"
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
