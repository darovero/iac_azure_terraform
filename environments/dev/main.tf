resource "random_integer" "resource_suffix" {
  min = 1
  max = 99
}

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
  location            = each.value.location
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