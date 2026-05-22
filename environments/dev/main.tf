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

