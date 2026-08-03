resource "azurerm_resource_group" "tf_rg" {
  name     = local.tf_rg_name
  location = var.location

  tags = merge(module.metadata.tags, { what_is_this = "Terraform State Resource Group" })
}

resource "azurerm_resource_group" "shared_rg" {
  name     = local.shared_rg_name
  location = var.location

  tags = merge(module.metadata.tags, { what_is_this = "Shared Resource Group" })
}
