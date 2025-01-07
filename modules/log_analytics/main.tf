resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = 30  # Puedes ajustar el tiempo de retención de datos si lo prefieres

  tags = var.tags
}
