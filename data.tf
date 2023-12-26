data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}
