resource "azurerm_resource_group" "identities" {
  name     = local.identity_rg_name
  location = var.location

  tags = merge(var.tags, { what_is_this = "GitHub Actions Resource Group" })
}
