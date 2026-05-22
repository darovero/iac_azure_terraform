resource "azurerm_mssql_elasticpool" "this" {
  name                = var.elastic_pool_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.server_name
  max_size_bytes      = var.max_size_bytes

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    family   = var.sku_family
    capacity = var.vcores
  }

  per_database_settings {
    min_capacity = var.min_capacity_per_db
    max_capacity = var.max_capacity_per_db
  }

  tags = var.tags
}