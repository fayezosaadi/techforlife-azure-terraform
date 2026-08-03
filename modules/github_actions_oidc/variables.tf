variable "github_org" {
  description = "GitHub organization name"
  type        = string
  default     = "fayezosaadi"
}

variable "github_org_id" {
  type        = string
  description = "The numeric ID of the GitHub organization"
  default     = "26156279"
}

variable "repositories" {
  type        = map(string)
  description = "A map of repository names to their numeric GitHub repository IDs"
  default = {
    "techforlife-azure-terraform" = "1320398734"
  }
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "eastus"
}

variable "subscription_id" {
  description = "Azure subscription id"
  type        = string
}

variable "storage_id" {
  description = "Azure storage id"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
