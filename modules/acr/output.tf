output "acr_login_server" {
  description = "Login server del Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}
