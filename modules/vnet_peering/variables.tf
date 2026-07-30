variable "local_to_remote_peering_name" {
  description = "The name of the virtual network peering from local to remote."
  type        = string
}

variable "remote_vnet_id" {
  description = "The ID of the remote virtual network to peer with."
  type        = string
}

variable "local_vnet_id" {
  description = "The ID of the local virtual network to peer with."
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

variable "remote_to_local_peering_name" {
  description = "The name of the virtual network peering from remote to local."
  type        = string
}

variable "local_rg_name" {
  description = "The name of the resource group containing the local virtual network."
  type        = string
}

variable "local_vnet_name" {
  description = "The name of the local virtual network."
  type        = string
}

variable "remote_rg_name" {
  description = "The name of the resource group containing the remote virtual network."
  type        = string
}

variable "remote_vnet_name" {
  description = "The name of the remote virtual network."
  type        = string
}