variable "environment" {
  type = string
}

variable "project" {
  description = "The GCP project ID where the GKE cluster is located"
  type        = string
}

variable "gitops_repo_name" {
  description = "Name of the GitOps repository where Flux will manage resources"
  type        = string
}

variable "charts_repo_name" {
  description = "Name of the Helm Charts repository where Flux will update charts"
  type        = string
}
