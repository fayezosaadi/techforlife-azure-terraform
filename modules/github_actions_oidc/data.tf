data "azuread_application_published_app_ids" "well_known" {
  count = var.grant_msgraph_readonly_application_permissions || var.grant_msgraph_readwrite_application_permissions ? 1 : 0
}

data "azuread_service_principal" "msgraph" {
  count = var.grant_msgraph_readonly_application_permissions || var.grant_msgraph_readwrite_application_permissions ? 1 : 0

  client_id = data.azuread_application_published_app_ids.well_known[0].result["MicrosoftGraph"]
}
