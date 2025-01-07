terraform {
  backend "azurerm" {
    resource_group_name   = "tfstateRG-dev"
    storage_account_name  = "stoacctf01"
    container_name        = "tfstestdev01"
    key                   = "terraform-dev01.tfstate"
  }
}
