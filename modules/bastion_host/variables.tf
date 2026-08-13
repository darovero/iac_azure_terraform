variable "bastion_name" {
  description = "Azure Bastion Host name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where Azure Bastion will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "AzureBastionSubnet resource ID"
  type        = string
}

variable "sku" {
  description = "Azure Bastion SKU"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}