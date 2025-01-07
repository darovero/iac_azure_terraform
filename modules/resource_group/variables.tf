variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Ubicación del Resource Group"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags a aplicar al Resource Group"
  type        = map(string)
  default     = {}
}