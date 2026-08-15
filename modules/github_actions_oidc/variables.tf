variable "repositories" {
  type = map(object({
    id = string
    org = object({
      id   = string
      name = string
    })
  }))
  description = "A list of repository names"
}

variable "readonly_role_assignments" {
  type = map(object({
    role_name = string
    scope     = string
  }))

  default = {}
}

variable "readwrite_role_assignments" {
  type = map(object({
    role_name = string
    scope     = string
  }))

  default = {}
}

variable "grant_msgraph_readonly_application_permissions" {
  description = "When true, grants the read-only identity the Microsoft Graph Application.Read.All application permission with admin consent, so it can read Entra app registrations during 'terraform plan' (e.g. state refresh of azuread_application resources)."
  type        = bool
  default     = false
}

variable "grant_msgraph_readwrite_application_permissions" {
  description = "When true, grants the read-write identity the Microsoft Graph Application.ReadWrite.OwnedBy application permission with admin consent, so it can create/manage Entra app registrations (e.g. via azuread_application resources)."
  type        = bool
  default     = false
}
