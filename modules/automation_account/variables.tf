variable "automation_account_name" {
  description = "Azure Automation Account name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the Automation Account will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku_name" {
  description = "Automation Account SKU"
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Free"], var.sku_name)
    error_message = "sku_name must be Basic or Free."
  }
}

variable "public_network_access_enabled" {
  description = "Enables public network access to the Automation Account"
  type        = bool
  default     = true
}

variable "local_authentication_enabled" {
  description = "Enables local/non-Entra authentication"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Managed Identity type"
  type        = string
  default     = "SystemAssigned"

  validation {
    condition = var.identity_type == null || contains([
      "SystemAssigned",
      "UserAssigned",
      "SystemAssigned, UserAssigned"
    ], var.identity_type)

    error_message = "identity_type must be SystemAssigned, UserAssigned, SystemAssigned, UserAssigned, or null."
  }
}

variable "identity_ids" {
  description = "User Assigned Managed Identity IDs"
  type        = set(string)
  default     = null
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}