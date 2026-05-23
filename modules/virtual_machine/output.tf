output "vm_id" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
}

output "vm_name" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_virtual_machine.this[0].name : azurerm_windows_virtual_machine.this[0].name
}

output "vm_private_ip" {
  value = azurerm_network_interface.this.private_ip_address
}

output "vm_public_ip" {
  value = var.enable_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "network_interface_id" {
  value = azurerm_network_interface.this.id
}