resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version # Cambiado a sql_server_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  tags = var.tags
}