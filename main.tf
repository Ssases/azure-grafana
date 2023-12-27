## ---------------------------------------------------
# Managed Grafana
## ---------------------------------------------------
resource "azurerm_dashboard_grafana" "default" {
  name                              = "grafana-testing"
  resource_group_name               = "My-app"
  location                          = "WEST US"
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true

  identity {
    type = "SystemAssigned"
  }
}

# Add required role assignment over resource group containing the Azure Monitor Workspace
resource "azurerm_role_assignment" "grafana_monit" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Monitoring Reader"
  principal_id         = data.azurerm_client_config.example.object_id
}

# Add role assignment to Grafana so an admin user can log in
resource "azurerm_role_assignment" "grafana-admin_one" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Grafana Admin"
  principal_id         = data.azurerm_client_config.example.object_id
}

resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_dashboard_grafana.default.identity[0].principal_id
}

resource "azurerm_role_assignment" "grafana-admin_user" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Grafana Admin"
  principal_id         = "00c9aae8-89ad-4b02-b6b2-1f5a62167606"
}

# Output the grafana url for usability
output "grafana_url" {
  value = azurerm_dashboard_grafana.default.endpoint
} 
