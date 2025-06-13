variable "name" {
  description = "Nombre del workspace de Databricks"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del resource group"
  type        = string
}

variable "location" {
  description = "Ubicación del recurso"
  type        = string
}

variable "tags" {
  description = "Tags aplicados"
  type        = map(string)
}
