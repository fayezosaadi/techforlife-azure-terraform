module "github_actions_primary_tenant" {
  source = "./modules/github_actions_oidc"

  repositories = {
    "techforlife-azure-terraform" = {
      id = "1320398734"
      org = {
        id   = "26156279"
        name = "fayezosaadi"
      }
    }
    "foundry-ai-chatapp-infrastructure" = {
      id = "1285215945"
      org = {
        id   = "26156279"
        name = "fayezosaadi"
      }
    }
  }

  readonly_role_assignments = {
    "storage_reader" = {
      role_name = "Reader and Data Access"
      scope     = azurerm_storage_account.tf_state.id
    }
    "subscription_reader" = {
      role_name = "Reader"
      scope     = data.azurerm_subscription.current.id
    }
  }

  readwrite_role_assignments = {
    "storage_reader" = {
      role_name = "Reader and Data Access"
      scope     = azurerm_storage_account.tf_state.id
    }
    "subscription_contributor" = {
      role_name = "Contributor"
      scope     = data.azurerm_subscription.current.id
    }
    "subscription_user_access_administrator" = {
      role_name = "User Access Administrator"
      scope     = data.azurerm_subscription.current.id
    }
  }
}
