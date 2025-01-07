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
  resource_group_count      = 2
  storage_account_count     = 1
  key_vault_count           = 1
  log_analytics_count       = 0
  sql_server_count          = 0
  elastic_pool_count        = 0
  virtual_network_count     = 0
  service_plan_windows      = 0
  service_plan_linux        = 0
  web_app_windows           = 0
  web_app_linux             = 0
  vm_windows                = 0
  vm_linux                  = 0
  application_gateway_count = 0

  # Configuración para crear solo subnets de 16 IPs
  subnet_16_ips_count = 2  # Ajustado para que todas las subnets sean de 16 IPs
  subnet_sizes = [28, 28, 28, 28]  # Usando solo subredes de 16 IPs
}

# Crear múltiples Resource Groups
module "resource_groups" {
  source              = "../modules/resource_group"
  count               = local.resource_group_count
  resource_group_name = "bogdevrg${random_integer.resource_suffix.result + count.index}"
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
  name                = "bogdevkv${random_integer.resource_suffix.result + count.index}"
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
  name                = "bogdevvnet${random_integer.resource_suffix.result + count.index}"
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
  name                 = "bogdevsta${random_integer.resource_suffix.result + count.index}"
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
  name                         = "bogdevsql${random_integer.resource_suffix.result + count.index}"
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
  name      = "bogdevdb${random_integer.resource_suffix.result + count.index}"
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
  service_plan_name   = "bogdevspw${random_integer.resource_suffix.result}"
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

# Log Analytics Workspaces
resource "azurerm_log_analytics_workspace" "log_analytics" {
  count               = local.log_analytics_count * local.resource_group_count
  name                = "bogdevlaw${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location
  sku                 = "PerGB2018"

  retention_in_days   = 30  # Configuración de retención, ajusta según tus necesidades

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }
}

module "service_plan_linux" {
  source              = "../modules/service_plan"
  count               = local.service_plan_linux > 0 ? 1 : 0
  service_plan_name   = "bogdevspl${random_integer.resource_suffix.result}"
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
  web_app_name        = "bogdevwaw${count.index + 1}${random_integer.resource_suffix.result}"
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
  web_app_name        = "bogdevwal${count.index + 1}${random_integer.resource_suffix.result}"
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
  vm_name             = "bogdevvmw${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > 0 ? local.subnet_ids[0][0] : ""
  vm_size             = "Standard_B2s"
  os_type             = "Windows"
  admin_username      = "winadmin"
  admin_password      = "SecurePassword123!"
  enable_public_ip    = true  # Activar IP pública para Windows

  image_publisher     = "MicrosoftWindowsServer"
  image_offer         = "WindowsServer"
  image_sku           = "2016-Datacenter"
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
  vm_name             = "bogdevvml${random_integer.resource_suffix.result + count.index}"
  location            = var.location
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id           = length(local.subnet_ids) > count.index ? local.subnet_ids[count.index % local.resource_group_count][1] : ""
  vm_size             = "Standard_B1s"
  os_type             = "Linux"
  admin_username      = "linuxadmin"
  admin_password      = "SecurePassword123!"

  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  disk_type           = "Standard_LRS"

  enable_public_ip    = true
  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }
}

module "application_gateway" {
  source                  = "../modules/application_gateway"
  count                   = local.application_gateway_count
  application_gateway_name = "bogdevagw${random_integer.resource_suffix.result + count.index}"
  location                = var.location
  resource_group_name     = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  subnet_id               = local.subnet_ids[count.index % length(local.subnet_ids)][3]  # Subnet 4

  enable_public_ip        = true
  sku_name                = "Standard_v2"
  sku_tier                = "Standard_v2"
  sku_capacity            = 2
  enable_https            = false # Cambia a true para habilitar HTTPS
  ssl_certificate_data    = var.ssl_certificate_data
  ssl_certificate_password = var.ssl_certificate_password

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "2.0.0"
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

module "elastic_pool" {
  source              = "../modules/elastic_pool"
  count               = local.elastic_pool_count * local.resource_group_count

  elastic_pool_name   = "bogdevepool${random_integer.resource_suffix.result + count.index}"
  resource_group_name = module.resource_groups[count.index % local.resource_group_count].resource_group_name
  location            = var.location

  # Asegurarse de que el servidor SQL corresponde al índice del grupo de recursos
  server_name         = azurerm_mssql_server.sql_server[count.index % local.resource_group_count].name

  vcores              = 2
  max_size_bytes      = 34359738368
  min_capacity_per_db = 0
  max_capacity_per_db = 1

  tags = {
    owner       = var.owner
    environment = var.environment
    tfv         = "1.0.0"
  }

  depends_on = [azurerm_mssql_server.sql_server]
}
