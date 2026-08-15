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
