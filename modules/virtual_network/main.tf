resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  
  tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_prefixes)
  name                = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes    = [var.subnet_prefixes[count.index]]  # Ajustado a address_prefixes (es una lista)

  # Otros atributos opcionales si necesitas agregar más configuraciones a las subredes
}
