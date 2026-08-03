resource "azurerm_storage_account" "tf_state" {
  name                            = local.tf_storage_account_name
  resource_group_name             = azurerm_resource_group.tf_rg.name
  location                        = azurerm_resource_group.tf_rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = merge(module.metadata.tags, { what_is_this = "Terraform State Storage Account" })

  lifecycle {
    prevent_destroy = true
  }
}