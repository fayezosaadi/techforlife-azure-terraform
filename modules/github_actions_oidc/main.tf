resource "azuread_application_registration" "github_actions_readonly" {
  display_name = "appreg-gha-runner-readonly"
}

resource "azuread_application_registration" "github_actions_readwrite" {
  display_name = "appreg-gha-runner-readwrite"
}

resource "azuread_service_principal" "readonly" {
  client_id   = azuread_application_registration.github_actions_readonly.client_id
  description = "GitHub Actions read-only service principal"
}

resource "azuread_service_principal" "readwrite" {
  client_id   = azuread_application_registration.github_actions_readwrite.client_id
  description = "GitHub Actions read-write service principal"
}

resource "azuread_application_federated_identity_credential" "pull_request" {
  for_each = var.repositories

  application_id = azuread_application_registration.github_actions_readonly.id
  display_name   = "fid-appreg-${each.key}-pull-request"
  description    = "Allows GitHub pull request workflows to access Azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${each.value.org.name}@${each.value.org.id}/${each.key}@${each.value.id}:pull_request"
}

resource "azuread_application_federated_identity_credential" "main_branch" {
  for_each = var.repositories

  application_id = azuread_application_registration.github_actions_readonly.id
  display_name   = "fid-appreg-${each.key}-main-branch"
  description    = "Allows GitHub main branch workflows to access Azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${each.value.org.name}@${each.value.org.id}/${each.key}@${each.value.id}:ref:refs/heads/main"
}

resource "azuread_application_federated_identity_credential" "production_environment" {
  for_each = var.repositories

  application_id = azuread_application_registration.github_actions_readwrite.id
  display_name   = "fid-appreg-${each.key}-production-environment"
  description    = "Allows GitHub production environment workflows to access Azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${each.value.org.name}@${each.value.org.id}/${each.key}@${each.value.id}:environment:production"
}

resource "azurerm_role_assignment" "readonly" {
  for_each = var.readonly_role_assignments

  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = azuread_service_principal.readonly.object_id
}

resource "azurerm_role_assignment" "readwrite" {
  for_each = var.readwrite_role_assignments

  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = azuread_service_principal.readwrite.object_id
}

resource "azuread_app_role_assignment" "readonly_msgraph" {
  count               = var.grant_msgraph_readonly_application_permissions ? 1 : 0
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Application.Read.All"]
  principal_object_id = azuread_service_principal.readonly.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

resource "azuread_app_role_assignment" "readwrite_msgraph" {
  count               = var.grant_msgraph_readwrite_application_permissions ? 1 : 0
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Application.ReadWrite.OwnedBy"]
  principal_object_id = azuread_service_principal.readwrite.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}
