
provider "google" {
  project = var.project
  region  = var.region
}
provider "github" {
  token = data.google_secret_manager_secret_version.github_token.secret_data
  owner = var.github_owner
}

provider "kubernetes" {
  host                   = "https://${module.gke_cluster.api_server_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.b64_ca_cert)
}

# Adding provider block here because of dependency on ssh key
provider "flux" {
  kubernetes = {
    host                   = var.api_server_endpoint
    cluster_ca_certificate = var.b64_ca_cert

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gcloud"
      args        = ["auth", "print-access-token"]
    }
  }

  git = {
    url = "ssh://git@github.com/${var.github_owner}/${var.gitops_repo_name}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.gitops_ssh_key.private_key_pem
    }
  }
}
