resource "azurerm_container_registry" "container_registry" {
  name                = local.shared_acr_name
  resource_group_name = azurerm_resource_group.shared_rg.name
  location            = azurerm_resource_group.shared_rg.location
  sku                 = "Basic"

  tags = merge(module.metadata.tags, { what_is_this = "Shared Container Registry" })
}