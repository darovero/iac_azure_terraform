output "key_vault_name" {
  description = "Nombre del Key Vault"
  value       = azurerm_key_vault.this.name  # Ajuste al nombre real del recurso
}

output "key_vault_id" {
  description = "ID del Key Vault"
  value       = azurerm_key_vault.this.id  # Ajuste al nombre real del recurso
}
