# Create namespace for Flux components
resource "kubernetes_namespace" "flux" {
  metadata {
    name = "flux-system"
  }
}

# Git ops key pair for Flux
resource "tls_private_key" "gitops_ssh_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "gitops_deploy_key" {
  repository = var.gitops_repo_name
  title      = "Flux Git ops Deploy Key"
  key        = tls_private_key.gitops_ssh_key.public_key_openssh
  read_only  = true
}

# Adding provider block here because of dependency on ssh key
provider "flux" {
  kubernetes = {
    host                   = var.api_server_endpoint
    cluster_ca_certificate = var.b64_ca_cert
    token                  = var.gcp_access_token
  }
  git = {
    url = "ssh://git@github.com/${var.github_owner}/${var.gitops_repo_name}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.gitops_ssh_key.private_key_pem
    }
  }
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

# Create kubernetes secret for Charts deploy key
resource "kubernetes_secret" "charts_deploy_key" {
  metadata {
    name      = "charts-deploy-key"
    namespace = kubernetes_namespace.flux.metadata[0].name
  }

  data = {
    identity     = tls_private_key.charts_ssh_key.private_key_pem
    identity_pub = tls_private_key.charts_ssh_key.public_key_openssh
    known_hosts  = local.github_known_hosts
  }
}

# GHCR credentials for Flux Image Automation
resource "kubernetes_secret" "ghcr_creds" {
  metadata {
    name      = "ghcr-credentials"
    namespace = kubernetes_namespace.flux.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "ghcr.io" = {
          username = "git"
          password = var.github_token
          email    = "flux@image-automation.com"
          # auth     = base64encode("git:${var.github_token}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "flux_bootstrap_git" "this" {
  namespace = kubernetes_namespace.flux.metadata[0].name
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]

  # Secret where the GitOps deploy will be stored
  secret_name = "gitops-deploy-key"

  # Path for flux to manage resources at in gitops repository
  path = "releases/${var.environment}"

  # interval of syncing the git repository
  interval = "15s"

  log_level = "debug"

  depends_on = [kubernetes_namespace.flux, github_repository_deploy_key.gitops_deploy_key]
}
