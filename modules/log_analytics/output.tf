output "log_analytics_id" {
  description = "Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_name" {
  description = "Log Analytics Workspace name"
  value       = azurerm_log_analytics_workspace.this.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace customer/workspace ID"
  value       = azurerm_log_analytics_workspace.this.workspace_id
}