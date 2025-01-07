variable "application_gateway_name" {
  description = "Nombre del Application Gateway"
  type        = string
}

variable "location" {
  description = "Ubicación del Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred para el Application Gateway"
  type        = string
}

variable "sku_name" {
  description = "SKU del Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "Tier del SKU del Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "sku_capacity" {
  description = "Capacidad del SKU del Application Gateway"
  type        = number
  default     = 2
}

variable "enable_public_ip" {
  description = "Indica si el Application Gateway tendrá una IP pública"
  type        = bool
  default     = false
}

variable "enable_https" {
  description = "Indica si el Application Gateway tendrá HTTPS habilitado"
  type        = bool
  default     = false
}

variable "ssl_certificate_data" {
  description = "Datos del certificado SSL (Base64)"
  type        = string
  default     = ""
}

variable "ssl_certificate_password" {
  description = "Contraseña del certificado SSL"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}
