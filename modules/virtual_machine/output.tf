output "vm_id" {
  description = "ID de la máquina virtual"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_private_ip" {
  description = "Dirección IP privada de la VM"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_public_ip" {
  description = "Dirección IP pública de la VM (si aplica)"
  value       = var.os_type == "Windows" ? azurerm_public_ip.vm_public_ip[0].ip_address : null
}

output "vm_name" {
  description = "Nombre de la máquina virtual"
  value       = azurerm_virtual_machine.vm.name
}
