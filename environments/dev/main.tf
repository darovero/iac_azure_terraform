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

module "container_registries" {
  source = "../../modules/acr"

  for_each = var.container_registries

  acr_name            = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
  tags                = merge(local.common_tags, each.value.tags)
}

module "aks_clusters" {
  source = "../../modules/aks"

  for_each = var.aks_clusters

  aks_name            = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)

  dns_prefix              = coalesce(each.value.dns_prefix, "${each.value.name}-dns")
  kubernetes_version      = each.value.kubernetes_version
  sku_tier                = each.value.sku_tier
  private_cluster_enabled = each.value.private_cluster_enabled
  default_node_pool_name  = each.value.default_node_pool_name
  node_count              = each.value.node_count
  vm_size                 = each.value.vm_size
  network_plugin          = each.value.network_plugin
  load_balancer_sku       = each.value.load_balancer_sku

  vnet_subnet_id = (
    each.value.vnet_key != null && each.value.subnet_key != null
    ? module.virtual_networks[each.value.vnet_key].subnet_ids[each.value.subnet_key]
    : null
  )

  tags = merge(local.common_tags, each.value.tags)

  depends_on = [
    module.resource_groups,
    module.virtual_networks
  ]
}

module "application_gateways" {
  source = "../../modules/application_gateway"

  for_each = var.application_gateways

  application_gateway_name = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].resource_group_name
  location                 = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)

  subnet_id = module.virtual_networks[each.value.vnet_key].subnet_ids[each.value.subnet_key]

  sku_name     = each.value.sku_name
  sku_tier     = each.value.sku_tier
  sku_capacity = each.value.sku_capacity

  enable_public_ip = each.value.enable_public_ip
  enable_https     = each.value.enable_https

  ssl_certificate_data     = each.value.ssl_certificate_data
  ssl_certificate_password = each.value.ssl_certificate_password

  tags = merge(local.common_tags, each.value.tags)

  depends_on = [
    module.virtual_networks
  ]
}

module "virtual_machines" {
  source = "../../modules/virtual_machine"

  for_each = var.virtual_machines

  vm_name             = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)

  subnet_id = module.virtual_networks[each.value.vnet_key].subnet_ids[each.value.subnet_key]

  os_type        = each.value.os_type
  vm_size        = each.value.vm_size
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  image_publisher = each.value.image_publisher
  image_offer     = each.value.image_offer
  image_sku       = each.value.image_sku
  image_version   = each.value.image_version

  disk_type        = each.value.disk_type
  enable_public_ip = each.value.enable_public_ip

  tags = merge(local.common_tags, each.value.tags)

  depends_on = [
    module.virtual_networks
  ]
}

module "service_plans" {
  source = "../../modules/service_plan"

  for_each = var.service_plans

  service_plan_name   = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].resource_group_name
  location            = coalesce(each.value.location, module.resource_groups[each.value.resource_group_key].resource_group_location)
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
  worker_count        = each.value.worker_count
  tags                = merge(local.common_tags, each.value.tags)
}