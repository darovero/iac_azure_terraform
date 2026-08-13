output "bastion_host_id" {
  description = "Azure Bastion Host ID"
  value       = azurerm_bastion_host.this.id
}

output "bastion_host_name" {
  description = "Azure Bastion Host name"
  value       = azurerm_bastion_host.this.name
}

output "bastion_public_ip_id" {
  description = "Azure Bastion Public IP resource ID"
  value       = azurerm_public_ip.this.id
}

output "bastion_public_ip_address" {
  description = "Azure Bastion Public IP address"
  value       = azurerm_public_ip.this.ip_address
}