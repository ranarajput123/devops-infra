# Create namespace for Flux components
resource "kubernetes_namespace" "flux" {
  metadata {
    name = "flux-system"
  }
}

# Create kubernetes secret for Charts deploy key
resource "kubernetes_secret" "charts_deploy_key" {
  metadata {
    name      = "charts-deploy-key"
    namespace = kubernetes_namespace.flux.metadata[0].name
  }

  data = {
    identity     = var.charts_private_key_pem
    identity_pub = var.charts_public_key_openssh
    known_hosts  = var.github_known_hosts
  }
}

# GHCR credentials for Flux Image Automation
resource "kubernetes_secret" "ghcr_creds" {
  metadata {
    name      = "ghcr-credentials"
    namespace = kubernetes_namespace.flux.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          username = "git"
          password = var.github_token
          email    = "flux@image-automation.com"
          auth     = base64encode("git:${var.github_token}")
        }
      }
    })
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

  depends_on = [kubernetes_namespace.flux]
}
