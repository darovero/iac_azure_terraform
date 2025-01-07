output "storage_account_name" {
  description = "El nombre del Storage Account creado"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_location" {
  description = "La ubicación del Storage Account creado"
  value       = azurerm_storage_account.storage.location
}

output "primary_blob_endpoint" {
  description = "El endpoint principal del blob storage"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}
