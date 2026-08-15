variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "eastus"
}

variable "external_client_id" {
  description = "The Application ID for the external tenant OIDC app registration"
  type        = string
  default     = null
  ephemeral   = true
}

variable "external_tenant_id" {
  description = "The Directory ID of the external tenant"
  type        = string
  default     = null
  ephemeral   = true
}
