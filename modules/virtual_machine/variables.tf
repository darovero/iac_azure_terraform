variable "vm_name" {
  description = "Nombre de la VM"
  type        = string
}

variable "location" {
  description = "Ubicación de la VM"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred donde se conectará la VM"
  type        = string
}

variable "vm_size" {
  description = "Tamaño de la VM"
  type        = string
  default     = "Standard_B1s"
}

variable "os_type" {
  description = "Tipo de sistema operativo (Windows o Linux)"
  type        = string
}

variable "admin_username" {
  description = "Nombre del usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Contraseña del administrador"
  type        = string
  sensitive   = true
}

variable "image_publisher" {
  description = "Publisher de la imagen de la VM"
  type        = string
}

variable "image_offer" {
  description = "Oferta de imagen de la VM"
  type        = string
}

variable "image_sku" {
  description = "SKU de la imagen de la VM"
  type        = string
}

variable "disk_type" {
  description = "Tipo de disco OS para la VM (ej. Standard_LRS o Premium_LRS)"
  type        = string
  default     = "Standard_LRS"
}

variable "enable_public_ip" {
  description = "Indica si la VM debe tener una IP pública (true/false)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para la VM"
  type        = map(string)
  default     = {}
}
