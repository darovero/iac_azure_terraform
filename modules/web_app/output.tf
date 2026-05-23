locals {
  web_app_name = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].name : azurerm_linux_web_app.this[0].name
  web_app_id   = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].id : azurerm_linux_web_app.this[0].id
  hostname     = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].default_hostname : azurerm_linux_web_app.this[0].default_hostname
}

output "web_app_name" {
  value = local.web_app_name
}

output "web_app_id" {
  value = local.web_app_id
}

output "web_app_default_hostname" {
  value = local.hostname
}