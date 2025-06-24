
provider "google" {
  project = var.project
  region  = var.region
}
provider "github" {
  token = data.google_secret_manager_secret_version.github_token.secret_data
  owner = var.github_owner
}

provider "kubernetes" {
  # host                   = "https://${module.gke_cluster.api_server_endpoint}"
  # token                  = data.google_client_config.default.access_token
  # cluster_ca_certificate = base64decode(module.gke_cluster.b64_ca_cert)
  config_path = "~/.kube/config"
}
