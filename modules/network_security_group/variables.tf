variable "nsg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_ids" {
  description = "Map of subnet IDs to associate with the NSG"
  type        = map(string)
  default     = {}
}

variable "security_rules" {
  description = "NSG security rules"
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}