output "nsg_id" {
  value = azurerm_network_security_group.this.id
}

output "nsg_name" {
  value = azurerm_network_security_group.this.name
}

output "subnet_nsg_association_ids" {
  value = {
    for key, assoc in azurerm_subnet_network_security_group_association.this :
    key => assoc.id
  }
}