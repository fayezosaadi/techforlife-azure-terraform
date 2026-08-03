module "github_actions_oidc" {
  source          = "./modules/github_actions_oidc"
  subscription_id = data.azurerm_subscription.current.id
  storage_id      = azurerm_storage_account.tf_state.id
  tags            = module.metadata.tags
}
