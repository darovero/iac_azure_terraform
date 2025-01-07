resource "azurerm_mssql_elasticpool" "elastic_pool" {
  name                = var.elastic_pool_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.server_name

  sku {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = var.vcores
  }

  per_database_settings {
    min_capacity = var.min_capacity_per_db
    max_capacity = var.max_capacity_per_db
  }

  max_size_bytes = var.max_size_bytes

  tags = var.tags
}
