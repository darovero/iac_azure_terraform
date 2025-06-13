variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group donde se creará el ACR"
  type        = string
}

variable "location" {
  description = "Ubicación del ACR"
  type        = string
}

variable "tags" {
  description = "Etiquetas aplicadas al recurso"
  type        = map(string)
  default     = {}
}
