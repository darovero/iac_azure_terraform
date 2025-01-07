output "resource_group_name" {
  description = "El nombre del Resource Group creado"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "La ubicación del Resource Group creado"
  value       = azurerm_resource_group.rg.location
}
