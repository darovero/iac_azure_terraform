# Location for Azure resources
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

# Tenant ID for Azure AD
variable "tenant_id" {
  description = "Tenant ID for the Azure Active Directory"
  type        = string
  default     = "tu-tenant-id-aqui"  # Cambia este valor
}

# Name of the Key Vault
variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "nombre_keyvault_dev"  # Cambia este valor
}

# Owner of the resources
variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "dev_owner"  # Cambia este valor
}

# Environment of the resources
variable "environment" {
  description = "Environment of the resources (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

# Access policies for Key Vault
variable "access_policies" {
  description = "List of access policies for the Key Vault"
  type        = list(object({
    object_id = string
    permissions = object({
      keys         = list(string)
      secrets      = list(string)
      certificates = list(string)
    })
  }))
  default = [
    {
      object_id   = "03377bc2-c5ad-4bb7-9355-12ee5998ba89"
      permissions = {
        keys         = ["Get", "List", "Create", "Delete"]
        secrets      = ["Get", "List", "Set", "Delete"]
        certificates = ["Get", "List", "Create", "Delete"]
      }
    },
    {
      object_id   = "386ca0c1-27c5-4ca4-a336-cbc692f4dcf5"
      permissions = {
        keys         = ["Get", "List"]
        secrets      = ["Get", "List"]
        certificates = ["Get", "List"]
      }
    }
  ]
}
