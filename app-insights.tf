resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = local.shared_log_workspace_name
  location            = azurerm_resource_group.shared_rg.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = merge(module.metadata.tags, { what_is_this = "Shared Log Analytics Workspace" })
}

resource "azurerm_application_insights" "app_insights" {
  name                = local.shared_app_insights_name
  location            = azurerm_resource_group.shared_rg.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  workspace_id        = azurerm_log_analytics_workspace.log_workspace.id
  application_type    = "web"

  tags = merge(module.metadata.tags, { what_is_this = "Shared Application Insights" })
}
