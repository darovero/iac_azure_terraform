#######################################
# GENERAL CONFIGURATION
#######################################

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project" {
  description = "Project short name"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

#######################################
# RESOURCE GROUP
#######################################

variable "resource_groups" {
  description = "Resource Groups to create"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}

#######################################
# LOG ANALYTICS
#######################################

variable "log_analytics_workspaces" {
  description = "Log Analytics Workspaces to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    sku                = optional(string, "PerGB2018")
    retention_in_days  = optional(number, 30)
    tags               = optional(map(string), {})
  }))
  default = {}
}
#######################################
# SQL SERVER
#######################################

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}

#######################################
# VIRTUAL MACHINES
#######################################

variable "vm_admin_username" {
  description = "Virtual machine administrator username"
  type        = string
}

variable "vm_admin_password" {
  description = "Virtual machine administrator password"
  type        = string
  sensitive   = true
}

#######################################
# SSL CERTIFICATES
#######################################

variable "ssl_certificate_data" {
  description = "Base64 encoded SSL certificate"
  type        = string
  sensitive   = true
  default     = null
}

variable "ssl_certificate_password" {
  description = "SSL certificate password"
  type        = string
  sensitive   = true
  default     = null
}