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
    delegation       = optional(object({
      service_name    = string
      service_actions = list(string)
    }))
  }))
  default = {}
}