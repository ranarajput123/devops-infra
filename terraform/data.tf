// TODO check how to rotate it via pub sub topic through secret manager
data "google_secret_manager_secret_version" "github_token" {
  secret  = "github-token"
  project = var.project

  depends_on = [module.gcp]
}

data "google_client_config" "default" {}
