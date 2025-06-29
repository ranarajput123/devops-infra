variable "environment" {
  type = string
}

variable "project" {
  description = "The GCP project ID where the GKE cluster is located"
  type        = string
}

variable "charts_private_key_pem" {
  type      = string
  sensitive = true
}

variable "charts_public_key_openssh" {
  type = string
}
variable "github_known_hosts" {
  type = string
}
variable "github_token" {
  type      = string
  sensitive = true
}
