variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the Key Vault will be created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}