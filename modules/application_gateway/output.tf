output "application_gateway_id" {
  value = azurerm_application_gateway.this.id
}

output "application_gateway_name" {
  value = azurerm_application_gateway.this.name
}

output "application_gateway_frontend_ip" {
  value = var.enable_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "application_gateway_public_ip_id" {
  value = var.enable_public_ip ? azurerm_public_ip.this[0].id : null
}