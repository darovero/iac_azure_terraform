variable "function_app_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "service_plan_id" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_access_key" {
  type      = string
  sensitive = true
}

variable "os_type" {
  type = string

  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be Windows or Linux."
  }
}

variable "https_only" {
  type    = bool
  default = true
}

variable "always_on" {
  type    = bool
  default = false
}

variable "python_version" {
  type    = string
  default = null
}

variable "node_version" {
  type    = string
  default = null
}

variable "dotnet_version" {
  type    = string
  default = "v6.0"
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}