variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Ubicación de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones IP para la VNet"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "Lista de prefijos de direcciones para las subredes"
  type        = list(string)
  default     = []
}

variable "subnet_names" {
  description = "Lista de nombres para las subredes"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}