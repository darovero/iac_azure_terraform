resource "azurerm_data_factory" "this" {
  name                = var.data_factory_name
  location            = var.location
  resource_group_name = var.resource_group_name

  public_network_enabled          = var.public_network_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}