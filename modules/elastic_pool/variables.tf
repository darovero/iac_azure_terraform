variable "elastic_pool_name" {
  description = "Nombre del Elastic Pool"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación del recurso"
  type        = string
}

variable "server_name" {
  description = "Nombre del servidor SQL al que se asociará el Elastic Pool"
  type        = string
}

variable "vcores" {
  description = "Número de vCores para el Elastic Pool"
  type        = number
  default     = 2
}

variable "min_capacity_per_db" {
  description = "Capacidad mínima por base de datos"
  type        = number
  default     = 0
}

variable "max_capacity_per_db" {
  description = "Capacidad máxima por base de datos"
  type        = number
  default     = 1
}

variable "max_size_bytes" {
  description = "Tamaño máximo del Elastic Pool en bytes"
  type        = number
  default     = 34359738368 # 32 GB
}

variable "tags" {
  description = "Etiquetas para el recurso"
  type        = map(string)
  default     = {}
}
