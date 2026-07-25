# This module creates the Network Security Group (NSG) of the Jump Virtual Machine
resource "azurerm_network_security_group" "nsg_jump" {
  name                = "nsg-hubpro-jump"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH-Inbound-Admin"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.public_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-all-Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-PostgresSQL-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.jump_ip
    destination_address_prefix = var.postgresql_ip
  }

  security_rule {
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
}

# This module associates the NSG with the Jump Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc_jump" {
  subnet_id                 = azurerm_subnet.snet_jump.id
  network_security_group_id = azurerm_network_security_group.nsg_jump.id
}

# This module creates the Network Security Group (NSG) of the NVA Virtual Machine
resource "azurerm_network_security_group" "nsg_nva" {
  name                = "nsg-hubpro-nva"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  security_rule {
    name                       = "Allow-Internal-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-all-Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Internal-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
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
}

# This module associates the NVA with the Jump Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc_nva" {
  subnet_id                 = azurerm_subnet.snet_nva.id
  network_security_group_id = azurerm_network_security_group.nsg_nva.id
}

resource "azurerm_network_security_group" "nsg_postgresql" {
  name                = "nsg-hubpro-postgresql"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-PG-from-Jump"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.jump_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-PG-from-App2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.app2_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-all-Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
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
}

# This module associates the PostgreSQL Subnet with its NSG
resource "azurerm_subnet_network_security_group_association" "nsg_assoc_postgresql" {
  subnet_id                 = azurerm_subnet.snet_postgresql.id
  network_security_group_id = azurerm_network_security_group.nsg_postgresql.id
}

# This module creates the Network Security Group (NSG) of the App2 Virtual Machine
resource "azurerm_network_security_group" "nsg_app2" {
  name                = "nsg-hubpro-app2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Deny-all-Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-PostgresSQL-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.app2_ip
    destination_address_prefix = var.postgresql_ip
  }

  security_rule {
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
}

# This module associates the NSG with the App2 Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc_app2" {
  subnet_id                 = azurerm_subnet.snet_app2.id
  network_security_group_id = azurerm_network_security_group.nsg_app2.id
}