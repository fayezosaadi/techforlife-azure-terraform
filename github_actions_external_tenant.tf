module "github_actions_external_tenant" {
  source = "./modules/github_actions_oidc"

  providers = {
    azuread = azuread.external_tenant
  }

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
}
