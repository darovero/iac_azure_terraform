variable "vm_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "os_type" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "disk_type" {
  type    = string
  default = "Standard_LRS"
}

variable "enable_public_ip" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}