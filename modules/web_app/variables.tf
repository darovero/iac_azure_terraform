variable "os_type" {
  description = "Tipo de sistema operativo para la Web App (Windows o Linux)"
  type        = string
}

variable "web_app_name" {
  description = "Nombre base de la Web App"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se despliega la Web App"
  type        = string
}

variable "location" {
  description = "Ubicación de la Web App"
  type        = string
}

variable "service_plan_id" {
  description = "ID del Service Plan al que se asociará la Web App"
  type        = string
}

variable "tags" {
  description = "Etiquetas para la Web App"
  type        = map(string)
  default     = {}
}

variable "dotnet_version" {
  description = "Versión de .NET para las aplicaciones Windows"
  type        = string
  default     = "v6.0"
}
