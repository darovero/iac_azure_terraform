# Especificar el proveedor con versión compatible
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Proveedor de Azure con el subscription_id explícito
provider "azurerm" {
  features {}
  subscription_id = "c7142d9c-6420-4b6d-a608-d8b19fd4604b"
}

# Generar un número aleatorio inicial para los nombres de todos los recursos
resource "random_integer" "resource_suffix" {
  min = 01
  max = 99
}

# Definir la cantidad de instancias para cada recurso y configuración de subnets
locals {
  resource_group_count   = 2
  storage_account_count  = 1
  key_vault_count        = 1
  log_analytics_count    = 0
  sql_server_count       = 1
  virtual_network_count  = 0
  service_plan_windows   = 0
  service_plan_linux     = 0
  web_app_windows        = 0
  web_app_linux          = 0
  vm_windows             = 0
  vm_linux               = 0

  # Configuración para crear solo subnets de 16 IPs
  subnet_16_ips_count = 2  # Ajustado para que todas las subnets sean de 16 IPs
  subnet_sizes = [28, 28, 28, 28]  # Usando solo subredes de 16 IPs
}

# Crear múltiples Resource Groups
module "resource_groups" {
  source              = "../modules/resource_group"
  count               = local.resource_group_count
  resource_group_name = "uscddavp${random_integer.resource_suffix.result + count.index}rsg01"
  location            = var.location
  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }
}

# Key Vaults
resource "azurerm_key_vault" "key_vault" {
  count               = local.key_vault_count * local.resource_group_count
  name                = "uscddavp${random_integer.resource_suffix.result + count.index}akv01"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = "c2ea8a56-75d3-48d5-98dc-915348c8b405"

  # Configuración de políticas de acceso
  access_policy {
    tenant_id = "c2ea8a56-75d3-48d5-98dc-915348c8b405"
    object_id = "03377bc2-c5ad-4bb7-9355-12ee5998ba89"

    secret_permissions = ["Get", "List", "Set", "Delete"]
    key_permissions    = ["Get", "List", "Create", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Delete"]
  }

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# Crear múltiples Virtual Networks con `address_space` incrementado
resource "azurerm_virtual_network" "vnet" {
  count               = local.virtual_network_count * local.resource_group_count
  name                = "uscddavp${random_integer.resource_suffix.result + count.index}vnt01"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name

  # Address space incrementado para cada VNet
  address_space       = ["${10 + count.index}.0.0.0/16"]

  # Definir subredes dentro de cada VNet
  subnet {
    name             = "subnet1"
    address_prefixes = ["${10 + count.index}.0.1.0/29"]  # Subred de 8 IPs en cada VNet
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["${10 + count.index}.0.2.0/29"]  # Otra subred de 8 IPs en cada VNet
  }

  subnet {
    name             = "subnet3"
    address_prefixes = ["${10 + count.index}.0.3.0/28"]  # Subred de 16 IPs en cada VNet
  }

  subnet {
    name             = "subnet4"
    address_prefixes = ["${10 + count.index}.0.4.0/28"]  # Otra subred de 16 IPs en cada VNet
  }

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# Actualizar local.subnet_ids
locals {
  subnet_ids = [for vnet in azurerm_virtual_network.vnet : [for subnet in vnet.subnet : subnet.id]]
}

# Storage Accounts
resource "azurerm_storage_account" "storage_accounts" {
  count                = local.storage_account_count * local.resource_group_count
  name                 = "uscddavp${random_integer.resource_suffix.result + count.index}sta01"
  resource_group_name  = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location             = var.location
  account_tier         = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# SQL Servers
resource "azurerm_mssql_server" "sql_server" {
  count                        = local.sql_server_count * local.resource_group_count
  name                         = "uscddavp${random_integer.resource_suffix.result + count.index}sql01"
  resource_group_name          = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "P@ssw0rd1234!"

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# SQL Databases
resource "azurerm_mssql_database" "sql_database" {
  count     = local.sql_server_count * local.resource_group_count
  name      = "uscddavp${random_integer.resource_suffix.result + count.index}test01"
  server_id = azurerm_mssql_server.sql_server[count.index].id
  sku_name  = "S0"

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

module "service_plan_windows" {
  source              = "../modules/service_plan"
  count               = local.service_plan_windows > 0 ? 1 : 0
  service_plan_name   = "uscddavp${random_integer.resource_suffix.result}spw01"
  location            = var.location
  resource_group_name = module.resource_groups[0].resource_group_name
  os_type             = "Windows"
  sku_name            = "B1"  # Nivel básico

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

module "service_plan_linux" {
  source              = "../modules/service_plan"
  count               = local.service_plan_linux > 0 ? 1 : 0
  service_plan_name   = "uscddavp${random_integer.resource_suffix.result}spl01"
  location            = var.location
  resource_group_name = module.resource_groups[0].resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"  # Nivel básico

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# Web Apps Windows y Linux
module "web_app_windows" {
  source              = "../modules/web_app"
  count               = local.web_app_windows
  os_type             = "Windows"
  web_app_name        = "uscddavp${count.index + 1}${random_integer.resource_suffix.result}waw01"
  resource_group_name = module.resource_groups[0].resource_group_name
  location            = var.location
  service_plan_id     = local.service_plan_windows > 0 ? module.service_plan_windows[0].service_plan_id : null

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

module "web_app_linux" {
  source              = "../modules/web_app"
  count               = local.web_app_linux
  os_type             = "Linux"
  web_app_name        = "uscddavp${count.index + 1}${random_integer.resource_suffix.result}wal01"
  resource_group_name = module.resource_groups[0].resource_group_name
  location            = var.location
  service_plan_id     = local.service_plan_linux > 0 ? module.service_plan_linux[0].service_plan_id : null

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }
}

# VMs Windows y Linux
module "vm_windows" {
  source              = "../modules/virtual_machine"
  count               = local.vm_windows * local.resource_group_count
  vm_name             = "uscddavp${random_integer.resource_suffix.result + count.index}vmw01"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > 0 ? local.subnet_ids[0][0] : ""
  vm_size             = "Standard_B1s"
  os_type             = "Windows"
  admin_username      = "winadmin"
  admin_password      = "SecurePassword123!"

  image_publisher     = "MicrosoftWindowsServer"
  image_offer         = "WindowsServer"
  image_sku           = "2019-Datacenter"
  disk_type           = "Standard_LRS"

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }
}

module "vm_linux" {
  source              = "../modules/virtual_machine"
  count               = local.vm_linux * local.resource_group_count
  vm_name             = "uscddavp${random_integer.resource_suffix.result + count.index}vml01"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > 1 ? local.subnet_ids[0][1] : ""
  vm_size             = "Standard_B1s"
  os_type             = "Linux"
  admin_username      = "linuxadmin"
  admin_password      = "SecurePassword123!"

  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  disk_type           = "Standard_LRS"

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }
}