variable "environment" {
  type = string
}

variable "project" {
  description = "The GCP project ID where the GKE cluster is located"
  type        = string
}

variable "github_token" {
  description = "GitHub token for Flux operations"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub owner (user or organization) for Flux operations"
  type        = string
}

variable "api_server_endpoint" {
  description = "The API server endpoint for the GKE cluster"
  type        = string
}

variable "b64_ca_cert" {
  description = "Base64 encoded CA certificate for the GKE cluster"
  type        = string
}

variable "gcp_access_token" {
  description = "GCP access token for Flux operations"
  type        = string
  sensitive   = true
}

variable "gitops_repo_name" {
  description = "Name of the GitOps repository where Flux will manage resources"
  type        = string
}

variable "charts_repo_name" {
  description = "Name of the Helm Charts repository where Flux will update charts"
  type        = string
}