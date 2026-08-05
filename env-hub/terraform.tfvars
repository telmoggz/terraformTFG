# Hub Environment Terraform Variables
resource_group_name  = "rg-hubpro-01"
location             = "Central US"
virtual_network_name = "vnet-hubpro"

# Network Configuration
public_ip_address = "92.190.192.118"

# Source and destination private IPs for NSG rules
jump_ip       = "10.0.2.4"
postgresql_ip = "10.1.1.4"

# Account and SSH configuration for the Linux VM
admin_username      = "adminuser"
ssh_public_key_content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ+p/tiaQIw6MFoLIfPtnCqfVoLnpxLY88Nd7BYn5pEhHlm0EYXA1hbOFxYu4InMFItp4AqI+ZMc90QRpTEKxtB3VncFU16GaF5ETDT1AT+c9s2SsoLiF+HMgPf2tWbVyQ402YnAIgL97Gm9p8knHQjEN9mggfJTrwsh3b5pIiEGox3k3hCurxqt+aueMjOn1g6Qf5i6OnyJ6Go4xcXfa//KJ+x59OxxwHoA8zVKdxw/rYa+koth4oqX13PMiW2raG2Gd2l2BIFbNbZiu8iZZuubwsodkypU736HqNTohHTQGL4/qemxahPqwY64LidAlI4d+TLH3dEHi7ht37U+m/4kkv+pCfEsmkjMsWp4RL/kq71uVlEC+zShKYH00koSaNNqkBkpudt2rIXcD6vJVvGWrd+PBeoJSbXB1S5pw3fu/s7FML4ChpngTGjVzBOf6GAXFBGCOacrC2JzBL9jJ94YB/3+nQnIroC7uUsqftuvKG87fMHBgFCTkQkbOrtVkuS7+A1U591ZFAioQyj4flrSBmMQT+zhDlU0ZxxhyV+yKk1+2KcLN4Bhma7fxoDKTQIwBdXDcFPLAYiyXZWMWFqldUu0IKgHjCbQAyMMv/6Q0aZ8Ih25uD24tY2jdYxx2vkNRnqq8lXGfwHJApyPpCugNNlWg6bclPivpzRrPEYw== 34644@DESKTOP-U5O3CBL"

# Jump VM Configuration
jump_vm_name              = "vm-hubpro-jump"
jump_vm_size              = "Standard_F1als_v7"
jump_image_publisher      = "Canonical"
jump_image_offer          = "0001-com-ubuntu-server-jammy"
jump_image_sku            = "22_04-lts-gen2"
jump_image_version        = "latest"
jump_os_disk_caching      = "ReadWrite"
jump_storage_account_type = "Standard_LRS"

# NVA VM Configuration
nva_name                 = "vm-hubpro-nva"
nva_size                 = "Standard_F1als_v7"
nva_image_publisher      = "Canonical"
nva_image_offer          = "0001-com-ubuntu-server-jammy"
nva_image_sku            = "22_04-lts-gen2"
nva_image_version        = "latest"
nva_os_disk_caching      = "ReadWrite"
nva_storage_account_type = "Standard_LRS"
nva_enable_ip_forwarding = true