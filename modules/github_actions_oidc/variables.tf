variable "github_org" {
  description = "GitHub organization name"
  type        = string
  default     = "fayezosaadi"
}

variable "repositories" {
  description = "List of GitHub repositories"
  type        = list(string)
  default     = ["techforlife-azure-terraform"]
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
