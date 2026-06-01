output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.this.id
}

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.this.name
}

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_primary_key" {
  value     = azurerm_cosmosdb_account.this.primary_key
  sensitive = true
}

output "mongodb_connection_strings" {
  value = [
    "mongodb://${azurerm_cosmosdb_account.this.name}:${azurerm_cosmosdb_account.this.primary_key}@${replace(azurerm_cosmosdb_account.this.endpoint, "https://", "")}:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
  ]

  sensitive = true
}

output "mongodb_database_names" {
  value = {
    for key, db in azurerm_cosmosdb_mongo_database.this : key => db.name
  }
}

output "mongodb_collection_names" {
  value = {
    for key, collection in azurerm_cosmosdb_mongo_collection.this : key => collection.name
  }
}