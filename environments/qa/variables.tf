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

#######################################
# VIRTUAL NETWORK
#######################################
variable "virtual_networks" {
  description = "Virtual Networks to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    address_space      = list(string)

    subnets = optional(map(object({
      name             = string
      address_prefixes = list(string)
    })), {})

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "container_registries" {
  description = "Azure Container Registries to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    sku                = optional(string, "Basic")
    admin_enabled      = optional(bool, false)
    tags               = optional(map(string), {})
  }))
  default = {}
}

variable "kubernetes_clusters" {
  description = "AKS clusters to create"
  type = map(object({
    name                    = string
    resource_group_key      = string
    location                = optional(string)
    dns_prefix              = optional(string)
    kubernetes_version      = optional(string)
    sku_tier                = optional(string, "Free")
    private_cluster_enabled = optional(bool, false)
    default_node_pool_name  = optional(string, "default")
    node_count              = optional(number, 1)
    vm_size                 = optional(string, "Standard_B2s")
    vnet_key                = optional(string)
    subnet_key              = optional(string)
    network_plugin          = optional(string, "azure")
    load_balancer_sku       = optional(string, "standard")
    tags                    = optional(map(string), {})
  }))
  default = {}
}

variable "application_gateways" {
  description = "Application Gateways to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    vnet_key   = string
    subnet_key = string

    sku_name     = optional(string, "Standard_v2")
    sku_tier     = optional(string, "Standard_v2")
    sku_capacity = optional(number, 2)

    enable_public_ip = optional(bool, true)
    enable_https     = optional(bool, false)

    ssl_certificate_data     = optional(string, "")
    ssl_certificate_password = optional(string, "")

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "virtual_machines" {
  description = "Virtual Machines to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    vnet_key   = string
    subnet_key = string

    os_type        = string
    vm_size        = optional(string, "Standard_B1s")
    admin_username = string
    admin_password = string

    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = optional(string, "latest")

    disk_type        = optional(string, "Standard_LRS")
    enable_public_ip = optional(bool, false)

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "service_plans" {
  description = "App Service Plans to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    os_type            = string
    sku_name           = optional(string, "B1")
    worker_count       = optional(number, 1)
    tags               = optional(map(string), {})
  }))
  default = {}
}

variable "web_apps" {
  description = "Web Apps to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    service_plan_key = string
    os_type          = string

    https_only              = optional(bool, true)
    client_affinity_enabled = optional(bool, false)
    always_on               = optional(bool, false)

    windows_current_stack = optional(string, "dotnet")
    dotnet_version        = optional(string, "v6.0")

    docker_image_name   = optional(string)
    docker_registry_url = optional(string)

    app_settings = optional(map(string), {})
    tags         = optional(map(string), {})
  }))
  default = {}
}

variable "function_apps" {
  description = "Function Apps to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    service_plan_key    = string
    storage_account_key = string

    os_type    = string
    https_only = optional(bool, true)
    always_on  = optional(bool, false)

    python_version = optional(string)
    node_version   = optional(string)
    dotnet_version = optional(string, "v6.0")

    app_settings = optional(map(string), {})
    tags         = optional(map(string), {})
  }))
  default = {}
}

variable "application_insights" {
  description = "Application Insights resources to create"
  type = map(object({
    name                 = string
    resource_group_key   = string
    log_analytics_key    = string
    location             = optional(string)
    application_type     = optional(string, "web")
    retention_in_days    = optional(number, 90)
    daily_data_cap_in_gb = optional(number, 1)
    tags                 = optional(map(string), {})
  }))
  default = {}
}

variable "data_factories" {
  description = "Azure Data Factories to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    public_network_enabled          = optional(bool, true)
    managed_virtual_network_enabled = optional(bool, false)

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "network_security_groups" {
  description = "Network Security Groups to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    subnet_associations = optional(map(object({
      vnet_key   = string
      subnet_key = string
    })), {})

    security_rules = optional(map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), {})

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "managed_identities" {
  description = "User Assigned Managed Identities to create"
  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    tags               = optional(map(string), {})
  }))
  default = {}
}

variable "cosmosdb_mongodb_accounts" {
  description = "Cosmos DB MongoDB API accounts to create"
  type = map(object({
    name                 = string
    resource_group_key   = string
    location             = optional(string)
    offer_type           = optional(string, "Standard")
    mongo_server_version = optional(string, "4.2")
    consistency_level    = optional(string, "Session")

    databases = optional(map(object({
      name       = string
      throughput = optional(number)
    })), {})

    collections = optional(map(object({
      name         = string
      database_key = string
      shard_key    = string
      throughput   = optional(number)
    })), {})

    tags = optional(map(string), {})
  }))
  default = {}
}

variable "bastion_hosts" {
  description = "Azure Bastion Hosts to create"

  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    vnet_key   = string
    subnet_key = string

    sku = optional(string, "Basic")

    tags = optional(map(string), {})
  }))

  default = {}
}

module "bastion_hosts" {
  source = "../../modules/bastion_host"

  for_each = var.bastion_hosts

  bastion_name = each.value.name

  resource_group_name = module.resource_groups[
    each.value.resource_group_key
  ].resource_group_name

  location = coalesce(
    each.value.location,
    module.resource_groups[
      each.value.resource_group_key
    ].resource_group_location
  )

  subnet_id = module.virtual_networks[
    each.value.vnet_key
    ].subnet_ids[
    each.value.subnet_key
  ]

  sku = each.value.sku

  tags = merge(
    local.common_tags,
    each.value.tags
  )

  depends_on = [
    module.virtual_networks
  ]
}

variable "automation_accounts" {
  description = "Azure Automation Accounts to create"

  type = map(object({
    name               = string
    resource_group_key = string
    location           = optional(string)

    sku_name = optional(string, "Basic")

    public_network_access_enabled = optional(bool, true)
    local_authentication_enabled  = optional(bool, false)

    identity_type = optional(
      string,
      "SystemAssigned"
    )

    managed_identity_keys = optional(list(string), [])

    tags = optional(map(string), {})
  }))

  default = {}
}