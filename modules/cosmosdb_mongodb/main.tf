resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = var.offer_type
  kind                = "MongoDB"

  mongo_server_version = var.mongo_server_version

  consistency_policy {
    consistency_level = var.consistency_level
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableMongo"
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "this" {
  for_each = var.databases

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = each.value.throughput
}

resource "azurerm_cosmosdb_mongo_collection" "this" {
  for_each = var.collections

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_mongo_database.this[each.value.database_key].name

  shard_key  = each.value.shard_key
  throughput = each.value.throughput

  index {
    keys   = ["_id"]
    unique = true
  }
}