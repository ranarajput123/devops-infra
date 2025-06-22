data "google_secret_manager_secret_version" "github_token" {
  secret  = "github-token"
  project = var.project
}

data "google_client_config" "default" {}