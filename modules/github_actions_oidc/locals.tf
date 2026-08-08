locals {
  environment_map = {
    "prod"    = "prd"
    "default" = "prd"
  }

  network_identity = {
    workspace = "gh-identities"
    iteration = "1"
  }

  environment      = local.environment_map[terraform.workspace]
  name_suffix      = "${local.environment}${local.network_identity.iteration}"
  workspace        = lower(local.network_identity.workspace)
  identity_rg_name = "rg-${local.workspace}-${local.name_suffix}"
}
