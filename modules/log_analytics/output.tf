output "log_analytics_id" {
  description = "ID del Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.log_analytics.id
}

output "log_analytics_name" {
  description = "Nombre del Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.log_analytics.name
}
