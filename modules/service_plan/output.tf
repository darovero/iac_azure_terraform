output "service_plan_id" {
  value = azurerm_service_plan.this.id
}

output "service_plan_name" {
  value = azurerm_service_plan.this.name
}

output "service_plan_os_type" {
  value = azurerm_service_plan.this.os_type
}

output "service_plan_sku_name" {
  value = azurerm_service_plan.this.sku_name
}