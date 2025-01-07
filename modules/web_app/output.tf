output "web_app_names" {
  description = "Nombres de las aplicaciones web desplegadas"
  value       = [for app in azurerm_windows_web_app.web_app : app.name]
}

output "web_app_default_hostnames" {
  description = "Hostnames por defecto de las aplicaciones web desplegadas"
  value       = [for app in azurerm_windows_web_app.web_app : app.default_hostname]
}
