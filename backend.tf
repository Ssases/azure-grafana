terraform {
  backend "azurerm" {
    resource_group_name  = "azure-tf-rg"
    storage_account_name = "azuretfsa"
    container_name       = "azure-tf-backend"
    key                  = "dev.terraform.tfstate"
  }
}
