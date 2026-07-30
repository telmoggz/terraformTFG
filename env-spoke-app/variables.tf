variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "app2_ip" {
  description = "The IP address of the App2 VM."
  type        = string
}

variable "postgresql_ip" {
  description = "The IP address of the PostgreSQL VM."
  type        = string
}

variable "cmp_vm_name" {
  description = "The name of the CMP VM."
  type        = string
}

variable "cmp_vm_size" {
  description = "The size of the CMP VM."
  type        = string
}

variable "cmp_os_disk_caching" {
  description = "The caching type of the CMP VM's OS disk."
  type        = string
}

variable "cmp_storage_account_type" {
  description = "The storage account type for the CMP VM's OS disk."
  type        = string
}

variable "cmp_image_publisher" {
  description = "The publisher of the CMP VM image."
  type        = string
}

variable "cmp_image_offer" {
  description = "The offer of the CMP VM image."
  type        = string
}

variable "cmp_image_sku" {
  description = "The SKU of the CMP VM image."
  type        = string
}

variable "cmp_image_version" {
  description = "The version of the CMP VM image."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the CMP VM."
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key for the CMP VM."
  type        = string
}

