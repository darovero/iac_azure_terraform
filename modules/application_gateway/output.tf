output "application_gateway_id" {
  description = "ID del Application Gateway"
  value       = azurerm_application_gateway.application_gateway.id
}

output "application_gateway_name" {
  description = "Nombre del Application Gateway"
  value       = azurerm_application_gateway.application_gateway.name
}

output "application_gateway_frontend_ip" {
  description = "Dirección IP pública del Application Gateway (si está habilitada)"
  value       = var.enable_public_ip && length(azurerm_public_ip.gateway_public_ip) > 0 ? azurerm_public_ip.gateway_public_ip[0].ip_address : null
}
