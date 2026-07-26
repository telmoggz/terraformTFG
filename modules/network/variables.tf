variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string

}

variable "location" {
  description = "The Azure region where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnets to create within the virtual network."
  type = map(object({
    address_prefixes = list(string)
    delegation = optional(object({
      service_name    = string
      service_actions = list(string)
    }))
  }))
  default = {}
}

variable "hub_to_spoke_peering_name" {
  description = "The name of the virtual network peering from hub to spoke."
  type        = string
}

variable "spoke_vnet_id" {
  description = "The ID of the spoke virtual network to peer with."
  type        = string
}

variable "hub_vnet_id" {
  description = "The ID of the hub virtual network to peer with."
  type        = string
}

variable "forwarded_traffic" {
  description = "Whether to allow forwarded traffic in the virtual network peering."
  type        = bool
  default     = true
}

variable "virtual_network_access" {
  description = "Whether to allow virtual network access in the virtual network peering."
  type        = bool
  default     = true
}

variable "spoke_to_hub_peering_name" {
  description = "The name of the virtual network peering from spoke to hub."
  type        = string
}