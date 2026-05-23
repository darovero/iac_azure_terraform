variable "service_plan_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "os_type" {
  type = string

  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be Windows or Linux."
  }
}

variable "sku_name" {
  type    = string
  default = "B1"
}

variable "worker_count" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}