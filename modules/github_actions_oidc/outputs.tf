output "gha_ro" {
  value = {
    client_id = azuread_application_registration.github_actions_readonly.client_id
  }
}

output "gha_rw" {
  value = {
    client_id = azuread_application_registration.github_actions_readwrite.client_id
  }
}
