variable "service_plan_name" {
  description = "Nombre del Service Plan"
  type        = string
}

variable "location" {
  description = "Ubicación del recurso"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "os_type" {
  description = "Tipo de sistema operativo del Service Plan"
  type        = string
}

variable "sku_name" {
  description = "SKU del Service Plan"
  type        = string
}

variable "tags" {
  description = "Etiquetas del recurso"
  type        = map(string)
  default     = {}
}
