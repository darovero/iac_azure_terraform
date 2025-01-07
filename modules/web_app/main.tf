# Windows Web App
resource "azurerm_windows_web_app" "web_app" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = "${var.web_app_name}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  tags                = var.tags

  site_config {
    # Puedes incluir configuraciones específicas de Windows aquí si son compatibles
  }
}

# Linux Web App
resource "azurerm_linux_web_app" "web_app" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = "${var.web_app_name}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  tags                = var.tags

  site_config {
    # Puedes incluir configuraciones específicas de Linux aquí si son compatibles
  }
}
