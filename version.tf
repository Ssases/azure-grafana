terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.21.0"
    }
    grafana = {
         source  = "grafana/grafana"
         version = "1.40.1"
      }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "grafana" {
   alias = "cloud"

   url   = "https://grafana-testing-b3ggdvfwaybrg6a9.wus.grafana.azure.com"
  #  auth  = "data.local_file.grafana_token.content"
}