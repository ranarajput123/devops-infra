variable "project" {
  description = "value of the GCP project"
  type        = string
}

variable "region" {
  description = "value of the GCP region"
  type        = string
}

variable "environment" {
  description = "The environment for the GKE cluster (e.g., nonprod, prod)."
  type        = string

  validation {
    condition     = contains(["nonprod", "prod"], var.environment)
    error_message = "The environment must be either 'nonprod' or 'prod'."
  }
}

variable "github_owner" {
  description = "GitHub owner (user or organization)"
  type        = string
}

variable "gitops_repo_name" {
  description = "Name of the GitOps repository"
  type        = string
}

variable "charts_repo_name" {
  description = "Name of the Helm Charts repository"
  type        = string
}
