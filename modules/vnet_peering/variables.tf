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