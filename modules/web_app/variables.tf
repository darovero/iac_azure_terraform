variable "web_app_name" {
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

variable "client_affinity_enabled" {
  type    = bool
  default = false
}

variable "always_on" {
  type    = bool
  default = false
}

variable "windows_current_stack" {
  type    = string
  default = "dotnet"
}

variable "dotnet_version" {
  type    = string
  default = "v6.0"
}

variable "docker_image_name" {
  type    = string
  default = null
}

variable "docker_registry_url" {
  type    = string
  default = null
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}