output "rw_identity" {
  value = {
    client_id       = azurerm_user_assigned_identity.rw_identity.client_id
    tenant_id       = azurerm_user_assigned_identity.rw_identity.tenant_id
    subscription_id = var.subscription_id
  }
}

output "ro_identity" {
  value = {
    client_id       = azurerm_user_assigned_identity.ro_identity.client_id
    tenant_id       = azurerm_user_assigned_identity.ro_identity.tenant_id
    subscription_id = var.subscription_id
  }
}