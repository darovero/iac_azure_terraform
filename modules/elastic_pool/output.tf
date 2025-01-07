output "elastic_pool_id" {
  description = "ID del Elastic Pool creado"
  value       = azurerm_mssql_elasticpool.elastic_pool.id
}

output "elastic_pool_name" {
  description = "Nombre del Elastic Pool"
  value       = azurerm_mssql_elasticpool.elastic_pool.name
}
