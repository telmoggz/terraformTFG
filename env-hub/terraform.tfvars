# Hub Environment Terraform Variables
resource_group_name  = "rg-hubpro-01"
location             = "francecentral"
virtual_network_name = "vnet-hubpro"

# Network Configuration
public_ip_address = "92.190.192.118"

# Source and destination private IPs for NSG rules
jump_ip       = "10.0.2.4"
postgresql_ip = "10.1.1.4"

# Account and SSH configuration for the Linux VM
admin_username      = "adminuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"

# Jump VM Configuration
jump_vm_name              = "vm-hubpro-jump"
jump_vm_size              = "Standard_D2s_v3"
jump_image_publisher      = "Canonical"
jump_image_offer          = "0001-com-ubuntu-server-jammy"
jump_image_sku            = "22_04-lts-gen2"
jump_image_version        = "latest"
jump_os_disk_caching      = "ReadWrite"
jump_storage_account_type = "Standard_LRS"

# NVA VM Configuration
nva_name                 = "vm-hubpro-nva"
nva_size                 = "Standard_D2s_v3"
nva_image_publisher      = "Canonical"
nva_image_offer          = "0001-com-ubuntu-server-jammy"
nva_image_sku            = "22_04-lts-gen2"
nva_image_version        = "latest"
nva_os_disk_caching      = "ReadWrite"
nva_storage_account_type = "Standard_LRS"
nva_enable_ip_forwarding = true