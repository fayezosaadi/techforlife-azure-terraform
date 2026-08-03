locals {
  environment_map = {
    "prod" = "prd"
  }

  network_identity = {
    workspace = "shared"
    iteration = "1"
  }

  workspace               = lower(local.network_identity.workspace)
  environment             = local.environment_map[terraform.workspace]
  name_suffix             = "${local.environment}${local.network_identity.iteration}"
  shared_rg_name          = "rg-${local.workspace}-${local.name_suffix}"
  shared_acr_name         = "cr${local.workspace}${local.name_suffix}"
  tf_rg_name              = "rg-terraform-${local.name_suffix}"
  tf_storage_account_name = "sttfstate${local.name_suffix}"
}
