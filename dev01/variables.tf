variable "location" {
  description = "La ubicación en Azure donde se desplegarán los recursos"
  type        = string
  default     = "centralus"
}

variable "owner" {
  description = "Nombre del propietario"
  type        = string
  default     = "drvelasquezr@outlook.com"
}

variable "environment" {
  description = "Nombre del ambiente"
  type        = string
  default     = "dev"
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}