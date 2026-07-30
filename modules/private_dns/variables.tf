variable "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vnet_links" {
  description = "A map of virtual network links to create."
  type = map(object({
    vnet_id              = string
    registration_enabled = bool
  }))
}

variable "create_zone" {
  description = "Whether to create the private DNS zone."
  type        = bool
  default     = true
}