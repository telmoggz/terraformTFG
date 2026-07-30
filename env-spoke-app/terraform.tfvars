# Spoke2 Environment Terraform Variables
resource_group_name  = "rg-spokepro-02"
location             = "francecentral"
virtual_network_name = "vnet-spokepro2"
hub_resource_group_name = "rg-hubpro-01"

app2_ip = "10.2.1.4"
postgresql_ip = "10.1.1.4"

# Account and SSH configuration for the Linux VM
admin_username      = "adminuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"

# COmpute VM Configuration
cmp_vm_name              = "vm-spokepro2-cmp"
cmp_vm_size              = "Standard_D2s_v3"
cmp_image_publisher      = "Canonical"
cmp_image_offer          = "0001-com-ubuntu-server-jammy"
cmp_image_sku            = "22_04-lts-gen2"
cmp_image_version        = "latest"
cmp_os_disk_caching      = "ReadWrite"
cmp_storage_account_type = "Standard_LRS"

