output "subnet_ids" {
  description = "Lista de IDs de las subredes de la VNet"
  value       = [for subnet in azurerm_virtual_network.vnet.subnet : subnet.id]
}
