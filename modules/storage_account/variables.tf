variable "storage_account_name" {
  description = "Nombre del Storage Account"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group en el que se creará el Storage Account"
  type        = string
}

variable "location" {
  description = "Ubicación del Storage Account"
  type        = string
  default     = "eastus"
}

variable "sku" {
  description = "SKU del Storage Account"
  type        = string
  default     = "Standard_LRS"
}

variable "tags" {
  description = "Tags a aplicar al Storage Account"
  type        = map(string)
  default     = {}
}
