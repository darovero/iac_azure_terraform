variable "log_analytics_name" {
  description = "Nombre del Log Analytics Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group donde se creará el Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "Ubicación del Log Analytics Workspace"
  type        = string
  default     = "eastus"
}

variable "sku" {
  description = "SKU del Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "tags" {
  description = "Tags a aplicar al Log Analytics Workspace"
  type        = map(string)
  default     = {}
}
