locals {
  function_app_name = lower(var.os_type) == "linux" ? azurerm_linux_function_app.this[0].name : azurerm_windows_function_app.this[0].name
  function_app_id   = lower(var.os_type) == "linux" ? azurerm_linux_function_app.this[0].id : azurerm_windows_function_app.this[0].id
  default_hostname  = lower(var.os_type) == "linux" ? azurerm_linux_function_app.this[0].default_hostname : azurerm_windows_function_app.this[0].default_hostname
  principal_id      = lower(var.os_type) == "linux" ? azurerm_linux_function_app.this[0].identity[0].principal_id : azurerm_windows_function_app.this[0].identity[0].principal_id
}

output "function_app_name" {
  value = local.function_app_name
}

output "function_app_id" {
  value = local.function_app_id
}

output "function_app_default_hostname" {
  value = local.default_hostname
}

output "function_app_principal_id" {
  value = local.principal_id
}