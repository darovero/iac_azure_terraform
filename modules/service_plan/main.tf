resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type  # "Windows" o "Linux"
  sku_name            = var.sku_name  # Por ejemplo, "B1" para el básico de Linux o Windows

  tags = var.tags
}
