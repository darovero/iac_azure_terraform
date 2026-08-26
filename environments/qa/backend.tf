terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateRG-qa"
    storage_account_name = "stoaccqa01"
    container_name       = "terraformstate"
    key                  = "qa/terraform.tfstate"
  }
}
