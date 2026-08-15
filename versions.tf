terraform {
  required_version = "~> 1.15.0"

  backend "azurerm" {
    resource_group_name  = "rg-terraform-prd1"
    storage_account_name = "sttfstateprd1"
    container_name       = "shared"
    key                  = "shared-infra.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.9.0"
    }
  }
}
