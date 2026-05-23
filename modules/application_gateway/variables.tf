variable "application_gateway_name" {
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

variable "sku_name" {
  type    = string
  default = "Standard_v2"
}

variable "sku_tier" {
  type    = string
  default = "Standard_v2"
}

variable "sku_capacity" {
  type    = number
  default = 2
}

variable "enable_public_ip" {
  type    = bool
  default = true
}

variable "enable_https" {
  type    = bool
  default = false
}

variable "ssl_certificate_data" {
  type      = string
  sensitive = true
  default   = ""
}

variable "ssl_certificate_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}