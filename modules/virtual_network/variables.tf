variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "address_space" {
  description = "Virtual Network address space"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to create inside the Virtual Network"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}