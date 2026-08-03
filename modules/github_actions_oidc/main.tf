# ==========================================
# READ/WRITE MANAGED IDENTITY & CREDENTIALS
# ==========================================

resource "azurerm_user_assigned_identity" "rw_identity" {
  name                = "id-github-actions-runner-rw"
  resource_group_name = azurerm_resource_group.identities.name
  location            = azurerm_resource_group.identities.location
}

# Credential 1: Environment = production
resource "azurerm_federated_identity_credential" "rw_env_production" {
  for_each = toset(var.repositories)

  name                      = "github-rw-${each.key}-env-production"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.rw_identity.id

  subject = "repo:${var.github_org}/${each.key}:environment:production"
}

# ==========================================
# READ-ONLY MANAGED IDENTITY & CREDENTIALS
# ==========================================

resource "azurerm_user_assigned_identity" "ro_identity" {
  name                = "id-github-actions-runner-ro"
  location            = azurerm_resource_group.identities.location
  resource_group_name = azurerm_resource_group.identities.name
}

# Credential 1: Pull Request
resource "azurerm_federated_identity_credential" "ro_pull_request" {
  for_each = toset(var.repositories)

  name                      = "github-ro-${each.key}-pull-request"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.ro_identity.id

  subject = "repo:${var.github_org}/${each.key}:pull_request"
}

# Credential 2: Branch = main
resource "azurerm_federated_identity_credential" "ro_main_branch" {
  for_each = toset(var.repositories)

  name                      = "github-ro-${each.key}-branch-main"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.ro_identity.id

  subject = "repo:${var.github_org}/${each.key}:ref:refs/heads/main"
}

# ==========================================
# SUBSCRIPTION-LEVEL PERMISSIONS
# ==========================================

# Read/Write Identity gets Contributor to deploy infrastructure
resource "azurerm_role_assignment" "rw_subscription" {
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.rw_identity.principal_id
}

# Read-Only Identity gets Reader to run 'terraform plan' safely
resource "azurerm_role_assignment" "ro_subscription" {
  scope                = var.subscription_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.ro_identity.principal_id
}

# ==========================================
# STORAGE ACCOUNT PERMISSIONS (STATE FILE)
# ==========================================

# BOTH identities need "Reader and Data Access" to look up the storage keys & properties
resource "azurerm_role_assignment" "rw_storage_reader" {
  scope                = var.storage_id
  role_definition_name = "Reader and Data Access"
  principal_id         = azurerm_user_assigned_identity.rw_identity.principal_id
}

resource "azurerm_role_assignment" "ro_storage_reader" {
  scope                = var.storage_id
  role_definition_name = "Reader and Data Access"
  principal_id         = azurerm_user_assigned_identity.ro_identity.principal_id
}

# The Read/Write identity also needs to modify the state blob during a deployment
resource "azurerm_role_assignment" "rw_storage_blob" {
  scope                = var.storage_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.rw_identity.principal_id
}

# The Read-Only identity only needs to see the state blob during plans
resource "azurerm_role_assignment" "ro_storage_blob" {
  scope                = var.storage_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.ro_identity.principal_id
}
