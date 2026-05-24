resource "azurerm_application_insights" "this" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  workspace_id        = var.workspace_id

  retention_in_days   = var.retention_in_days
  daily_data_cap_in_gb = var.daily_data_cap_in_gb

  tags = var.tags
}