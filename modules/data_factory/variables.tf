variable "data_factory_name" {
  description = "Nombre del Azure Data Factory"
  type        = string
}

variable "location" {
  description = "Ubicación donde se desplegará el ADF"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "tags" {
  description = "Etiquetas para el recurso"
  type        = map(string)
  default     = {}
}
