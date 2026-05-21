resource "random_integer" "resource_suffix" {
  min = 1
  max = 99
}

locals {
  common_tags = {
    owner       = var.owner
    environment = var.environment
    project     = var.project
    managed_by  = "terraform"
    tfv         = "2.0.0"
  }

  resource_group_count      = 2
  storage_account_count     = 2
  key_vault_count           = 1
  log_analytics_count       = 0
  sql_server_count          = 1
  elastic_pool_count        = 0
  virtual_network_count     = 1
  service_plan_windows      = 0
  service_plan_linux        = 0
  web_app_windows           = 0
  web_app_linux             = 0
  vm_windows                = 0
  vm_linux                  = 0
  application_gateway_count = 0
  aks_count                 = 0
  acr_count                 = 0
  data_factory_count        = 1
  databricks_count          = 0
}

module "resource_groups" {
  source = "../../modules/resource_group"
  count  = local.resource_group_count

  resource_group_name = "bogdevrg${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  tags                = local.common_tags
}

resource "azurerm_key_vault" "key_vault" {
  count = local.key_vault_count * local.resource_group_count

  name                = "bogdevkv${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.key_vault_admin_object_id

    secret_permissions      = ["Get", "List", "Set", "Delete"]
    key_permissions         = ["Get", "List", "Create", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Delete"]
  }

  tags = local.common_tags
}

resource "azurerm_virtual_network" "vnet" {
  count = local.virtual_network_count * local.resource_group_count

  name                = "bogdevvnet${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  address_space       = ["${10 + count.index}.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["${10 + count.index}.0.1.0/29"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["${10 + count.index}.0.2.0/29"]
  }

  subnet {
    name             = "subnet3"
    address_prefixes = ["${10 + count.index}.0.3.0/28"]
  }

  subnet {
    name             = "subnet4"
    address_prefixes = ["${10 + count.index}.0.4.0/28"]
  }

  tags = local.common_tags
}

locals {
  subnet_ids = [
    for vnet in azurerm_virtual_network.vnet : [
      for subnet in vnet.subnet : subnet.id
    ]
  ]
}

resource "azurerm_storage_account" "storage_accounts" {
  count = local.storage_account_count * local.resource_group_count

  name                     = "bogdevsta${random_integer.resource_suffix.result + count.index}"
  resource_group_name      = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.common_tags
}

resource "azurerm_mssql_server" "sql_server" {
  count = local.sql_server_count * local.resource_group_count

  name                         = "bogdevsql${random_integer.resource_suffix.result + count.index}"
  resource_group_name          = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  tags = local.common_tags
}

resource "azurerm_mssql_database" "sql_database" {
  count = local.sql_server_count * local.resource_group_count

  name      = "bogdevdb${random_integer.resource_suffix.result + count.index}"
  server_id = azurerm_mssql_server.sql_server[count.index].id
  sku_name  = "S0"

  tags = local.common_tags
}

module "service_plan_windows" {
  source = "../../modules/service_plan"
  count  = local.service_plan_windows > 0 ? 1 : 0

  service_plan_name   = "bogdevspw${random_integer.resource_suffix.result}"
  location            = var.location
  resource_group_name = module.resource_groups[0].resource_group_name
  os_type             = "Windows"
  sku_name            = "B1"
  tags                = local.common_tags
}

module "log_analytics" {
  source = "../../modules/log_analytics"
  count  = local.log_analytics_count * local.resource_group_count

  log_analytics_name  = "bogdevlaw${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

module "service_plan_linux" {
  source = "../../modules/service_plan"
  count  = local.service_plan_linux > 0 ? 1 : 0

  service_plan_name   = "bogdevspl${random_integer.resource_suffix.result}"
  location            = var.location
  resource_group_name = module.resource_groups[0].resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = local.common_tags
}

module "web_app_windows" {
  source = "../../modules/web_app"
  count  = local.web_app_windows

  os_type             = "Windows"
  web_app_name        = "bogdevwaw${count.index + 1}${random_integer.resource_suffix.result}"
  resource_group_name = module.resource_groups[0].resource_group_name
  location            = var.location
  service_plan_id     = local.service_plan_windows > 0 ? module.service_plan_windows[0].service_plan_id : null
  tags                = local.common_tags
}

module "web_app_linux" {
  source = "../../modules/web_app"
  count  = local.web_app_linux

  os_type             = "Linux"
  web_app_name        = "bogdevwal${count.index + 1}${random_integer.resource_suffix.result}"
  resource_group_name = module.resource_groups[0].resource_group_name
  location            = var.location
  service_plan_id     = local.service_plan_linux > 0 ? module.service_plan_linux[0].service_plan_id : null
  tags                = local.common_tags
}

module "vm_windows" {
  source = "../../modules/virtual_machine"
  count  = local.vm_windows * local.resource_group_count

  vm_name             = "bogdevvmw${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > 0 ? local.subnet_ids[0][0] : ""
  vm_size             = "Standard_B2s"
  os_type             = "Windows"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  enable_public_ip    = true
  image_publisher     = "MicrosoftWindowsServer"
  image_offer         = "WindowsServer"
  image_sku           = "2016-Datacenter"
  disk_type           = "Standard_LRS"
  tags                = local.common_tags
}

module "vm_linux" {
  source = "../../modules/virtual_machine"
  count  = local.vm_linux * local.resource_group_count

  vm_name             = "bogdevvml${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > count.index ? local.subnet_ids[count.index % local.resource_group_count][1] : ""
  vm_size             = "Standard_B1s"
  os_type             = "Linux"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  disk_type           = "Standard_LRS"
  enable_public_ip    = true
  tags                = local.common_tags
}

module "application_gateway" {
  source = "../../modules/application_gateway"
  count  = local.application_gateway_count

  application_gateway_name = "bogdevagw${random_integer.resource_suffix.result + count.index}"
  location                 = var.location
  resource_group_name      = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id                = local.subnet_ids[count.index % length(local.subnet_ids)][3]
  enable_public_ip         = true
  sku_name                 = "Standard_v2"
  sku_tier                 = "Standard_v2"
  sku_capacity             = 2
  enable_https             = false
  ssl_certificate_data     = var.ssl_certificate_data
  ssl_certificate_password = var.ssl_certificate_password
  tags                     = local.common_tags

  depends_on = [azurerm_virtual_network.vnet]
}

module "elastic_pool" {
  source = "../../modules/elastic_pool"
  count  = local.elastic_pool_count * local.resource_group_count

  elastic_pool_name   = "bogdevepool${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  server_name         = azurerm_mssql_server.sql_server[count.index % local.resource_group_count].name
  vcores              = 2
  max_size_bytes      = 34359738368
  min_capacity_per_db = 0
  max_capacity_per_db = 1
  tags                = local.common_tags

  depends_on = [azurerm_mssql_server.sql_server]
}

module "aks" {
  source = "../../modules/aks"
  count  = local.aks_count

  aks_name            = "bogdevaks${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  node_count          = 1
  vm_size             = "Standard_B2s"
  kubernetes_version  = "1.29.15"
  tags                = local.common_tags
}

module "acr" {
  source = "../../modules/acr"
  count  = local.acr_count

  acr_name            = "bogdevacr${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  tags                = local.common_tags
}

module "data_factory" {
  source = "../../modules/data_factory"
  count  = local.data_factory_count * local.resource_group_count

  data_factory_name   = "bogdevadf${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  tags                = local.common_tags
}

module "databricks" {
  source = "../../modules/databricks"
  count  = local.databricks_count * local.resource_group_count

  name                = "bogdevdbw${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  tags                = local.common_tags
}