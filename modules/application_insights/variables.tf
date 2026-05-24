variable "application_insights_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "application_type" {
  type    = string
  default = "web"
}

variable "workspace_id" {
  type = string
}

variable "retention_in_days" {
  type    = number
  default = 90
}

variable "daily_data_cap_in_gb" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}