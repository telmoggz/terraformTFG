variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "public_ip_address" {
  description = "The public IP address to allow SSH access from."
  type        = string
}

variable "jump_ip" {
  description = "The private IP address of the jump server."
  type        = string
}

variable "postgresql_ip" {
  description = "The private IP address of the PostgreSQL server."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the Linux VM."
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key for the Linux VM."
  type        = string
}

variable "jump_vm_name" {
  description = "The name of the jump server VM."
  type        = string
}

variable "jump_vm_size" {
  description = "The size of the jump server VM."
  type        = string
}

variable "jump_image_publisher" {
  description = "The publisher of the image for the jump server VM."
  type        = string
}

variable "jump_image_offer" {
  description = "The offer of the image for the jump server VM."
  type        = string
}

variable "jump_image_sku" {
  description = "The SKU of the image for the jump server VM."
  type        = string
}

variable "jump_image_version" {
  description = "The version of the image for the jump server VM."
  type        = string
}   

variable "nva_name" {
  description = "The name of the NVA server VM."
  type        = string
}

variable "nva_size" {
  description = "The size of the NVA server VM."
  type        = string
}

variable "nva_image_publisher" {
  description = "The publisher of the image for the NVA server VM."
  type        = string
}

variable "nva_image_offer" {
  description = "The offer of the image for the NVA server VM."
  type        = string
}

variable "nva_image_sku" {
  description = "The SKU of the image for the NVA server VM."
  type        = string
}

variable "nva_image_version" {
  description = "The version of the image for the NVA server VM."
  type        = string
}

variable "jump_os_disk_caching" {
  description = "The caching mode of the OS disk for the jump server VM."
  type        = string
}

variable "jump_storage_account_type" {
  description = "The storage account type of the OS disk for the jump server VM."
  type        = string
}

variable "nva_os_disk_caching" {
  description = "The caching mode of the OS disk for the NVA server VM."
  type        = string
}

variable "nva_storage_account_type" {
  description = "The storage account type of the OS disk for the NVA server VM."
  type        = string
}

