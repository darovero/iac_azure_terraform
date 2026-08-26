output "automation_account_id" {
  description = "Automation Account resource ID"
  value       = azurerm_automation_account.this.id
}

output "automation_account_name" {
  description = "Automation Account name"
  value       = azurerm_automation_account.this.name
}

output "automation_account_principal_id" {
  description = "System Assigned Managed Identity Principal ID"
  value = (
    length(azurerm_automation_account.this.identity) > 0
    ? azurerm_automation_account.this.identity[0].principal_id
    : null
  )
}

output "automation_account_tenant_id" {
  description = "Automation Account Managed Identity Tenant ID"
  value = (
    length(azurerm_automation_account.this.identity) > 0
    ? azurerm_automation_account.this.identity[0].tenant_id
    : null
  )
}