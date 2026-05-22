variable "sql_server_name" {
  description = "Azure SQL Server name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "admin_username" {
  description = "SQL Server admin username"
  type        = string
}

variable "admin_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "sql_server_version" {
  description = "SQL Server version"
  type        = string
  default     = "12.0"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}