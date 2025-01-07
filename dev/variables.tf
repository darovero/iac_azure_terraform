variable "location" {
  description = "La ubicación en Azure donde se desplegarán los recursos"
  type        = string
  default     = "eastus2"
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

variable "application_gateway_count" {
  description = "Número de Application Gateways a desplegar"
  type        = number
  default     = 0
}

variable "ssl_certificate_data" {
  description = "Certificado SSL en base64 para Application Gateway (opcional)"
  type        = string
  default     = ""
}

variable "ssl_certificate_password" {
  description = "Contraseña del certificado SSL (opcional)"
  type        = string
  default     = ""
}