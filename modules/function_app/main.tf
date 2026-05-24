resource "azurerm_linux_function_app" "this" {
  count = lower(var.os_type) == "linux" ? 1 : 0

  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  https_only = var.https_only

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = var.always_on

    application_stack {
      python_version = var.python_version
      node_version   = var.node_version
    }
  }

  app_settings = var.app_settings
  tags         = var.tags
}

resource "azurerm_windows_function_app" "this" {
  count = lower(var.os_type) == "windows" ? 1 : 0

  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  https_only = var.https_only

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = var.always_on

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = var.app_settings
  tags         = var.tags
}