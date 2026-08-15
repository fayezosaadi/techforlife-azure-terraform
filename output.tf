output "gha_pr_main" {
  value = {
    "primary_tenant"  = module.github_actions_primary_tenant.gha_ro
    "external_tenant" = module.github_actions_external_tenant.gha_ro
  }
}

output "gha_prod_env" {
  value = {
    "primary_tenant"  = module.github_actions_primary_tenant.gha_rw
    "external_tenant" = module.github_actions_external_tenant.gha_rw
  }
}
