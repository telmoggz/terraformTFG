variable "create_public_ip" {
  description = "Whether to create a public IP address for the virtual machine."
  type        = bool
  default     = false
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the virtual machine."
  type        = string
}

variable "size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "ssh_public_key_content" {
  description = "The content of the SSH public key for the virtual machine."
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the image to use for the virtual machine."
  type        = string
}

variable "image_offer" {
  description = "The offer of the image to use for the virtual machine."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image to use for the virtual machine."
  type        = string
}

variable "image_version" {
  description = "The version of the image to use for the virtual machine."
  type        = string
}

variable "os_disk_caching" {
  description = "The caching mode of the OS disk."
  type        = string
}

variable "storage_account_type" {
  description = "The storage account type of the OS disk."
  type        = string
}

variable "enable_ip_forwarding" {
  description = "Whether to enable IP forwarding on the network interface."
  type        = bool
  default     = false
}