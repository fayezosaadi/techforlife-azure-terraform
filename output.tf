output "github_actions_readonly_identities" {
  value = module.github_actions_oidc.ro_identity
}

output "github_actions_production_identities" {
  value = module.github_actions_oidc.rw_identity
}
