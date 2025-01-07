variable "sql_server_name" {
  description = "Nombre del servidor SQL"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Ubicación del servidor SQL"
  type        = string
  default     = "eastus"
}

variable "admin_username" {
  description = "Nombre de usuario del administrador para el servidor SQL"
  type        = string
}

variable "admin_password" {
  description = "Contraseña del administrador para el servidor SQL"
  type        = string
  sensitive   = true
}

variable "sql_server_version" {
  description = "Versión de SQL Server"
  type        = string
  default     = "12.0"
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}
