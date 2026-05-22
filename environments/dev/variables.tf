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
    location = optional(string)
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
# KEY VAULT
#######################################

variable "key_vaults" {
  description = "Key Vaults to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    sku_name           = optional(string, "standard")
    tags               = optional(map(string), {})
  }))
  default = {}
}
#######################################
# STORAGE ACCOUNT
#######################################

variable "storage_accounts" {
  description = "Storage Accounts to create"
  type = map(object({
    name                     = string
    resource_group_key       = string
    location                 = optional(string)
    account_tier             = optional(string, "Standard")
    account_replication_type = optional(string, "LRS")
    min_tls_version          = optional(string, "TLS1_2")
    tags                     = optional(map(string), {})
  }))
  default = {}
}

#######################################
# SQL SERVER
#######################################

variable "sql_servers" {
  description = "Azure SQL Servers to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    version            = optional(string, "12.0")
    admin_username     = string
    admin_password     = string
    tags               = optional(map(string), {})
  }))
  default = {}
}

#######################################
# ELASTIC POOL
#######################################

variable "elastic_pools" {
  description = "Azure SQL Elastic Pools to create"
  type = map(object({
    name                = string
    sql_server_key      = string
    resource_group_key  = string
    location            = optional(string)
    sku_name            = optional(string, "GP_Gen5")
    sku_tier            = optional(string, "GeneralPurpose")
    sku_family          = optional(string, "Gen5")
    vcores              = optional(number, 2)
    min_capacity_per_db = optional(number, 0)
    max_capacity_per_db = optional(number, 1)
    max_size_bytes      = optional(number, 34359738368)
    tags                = optional(map(string), {})
  }))
  default = {}
}