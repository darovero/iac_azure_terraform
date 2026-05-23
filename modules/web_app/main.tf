resource "azurerm_windows_web_app" "this" {
  count = lower(var.os_type) == "windows" ? 1 : 0

  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  https_only              = var.https_only
  client_affinity_enabled = var.client_affinity_enabled

  site_config {
    always_on = var.always_on

    application_stack {
      current_stack  = var.windows_current_stack
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = var.app_settings
  tags         = var.tags
}

resource "azurerm_linux_web_app" "this" {
  count = lower(var.os_type) == "linux" ? 1 : 0

  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  https_only              = var.https_only
  client_affinity_enabled = var.client_affinity_enabled

  site_config {
    always_on = var.always_on

    application_stack {
      docker_image_name   = var.docker_image_name
      docker_registry_url = var.docker_registry_url
    }
  }

  app_settings = var.app_settings
  tags         = var.tags
}