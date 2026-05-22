locals {
  common_tags = {
    owner       = var.owner
    environment = var.environment
    project     = var.project
    managed_by  = "terraform"
    tfv         = "2.0.0"
  }
}

module "resource_groups" {
  source = "../../modules/resource_group"

  for_each = var.resource_groups

  resource_group_name = each.value.name
  location            = coalesce(each.value.location, var.location)
  tags                = merge(local.common_tags, each.value.tags)
}

module "log_analytics_workspaces" {
  source = "../../modules/log_analytics"

  for_each = var.log_analytics_workspaces

  log_analytics_name  = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
  tags                = merge(local.common_tags, each.value.tags)
}

module "key_vaults" {
  source = "../../modules/key_vault"

  for_each = var.key_vaults

  key_vault_name      = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  tenant_id           = var.tenant_id
  sku_name            = each.value.sku_name
  tags                = merge(local.common_tags, each.value.tags)
}

module "storage_accounts" {
  source = "../../modules/storage_account"

  for_each = var.storage_accounts

  storage_account_name     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].resource_group_name
  location                 = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  min_tls_version          = each.value.min_tls_version
  tags                     = merge(local.common_tags, each.value.tags)
}

module "sql_servers" {
  source = "../../modules/sql_server"

  for_each = var.sql_servers

  sql_server_name     = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  sql_server_version  = each.value.version
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  tags                = merge(local.common_tags, each.value.tags)
}

module "elastic_pools" {
  source = "../../modules/elastic_pool"

  for_each = var.elastic_pools

  elastic_pool_name   = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  server_name         = module.sql_servers[each.value.sql_server_key].sql_server_name

  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  sku_family          = each.value.sku_family
  vcores              = each.value.vcores
  min_capacity_per_db = each.value.min_capacity_per_db
  max_capacity_per_db = each.value.max_capacity_per_db
  max_size_bytes      = each.value.max_size_bytes

  tags = merge(local.common_tags, each.value.tags)

  depends_on = [module.sql_servers]
}

module "virtual_networks" {
  source = "../../modules/virtual_network"

  for_each = var.virtual_networks

  vnet_name           = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = merge(local.common_tags, each.value.tags)
}