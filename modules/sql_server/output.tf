output "sql_server_name" {
  description = "Nombre del servidor SQL"
  value       = azurerm_mssql_server.sql_server.name # Cambiar a azurerm_mssql_server
}

output "sql_server_fqdn" {
  description = "FQDN del servidor SQL"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name # Cambiar a azurerm_mssql_server
}
