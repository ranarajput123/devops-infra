# Git ops key pair for Flux
resource "tls_private_key" "gitops_ssh_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "gitops_deploy_key" {
  repository = var.gitops_repo_name
  title      = "Flux Git ops Deploy Key"
  key        = tls_private_key.gitops_ssh_key.public_key_openssh
  read_only  = false
}


# Helm charts key pair for Flux
resource "tls_private_key" "charts_ssh_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "charts_deploy_key" {
  repository = var.charts_repo_name
  title      = "Flux Charts Deploy Key"
  key        = tls_private_key.charts_ssh_key.public_key_openssh
  read_only  = false
}
