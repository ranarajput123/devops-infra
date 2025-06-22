
provider "google" {
  project = var.project
  region  = var.region
}
provider "github" {
  token = data.google_secret_manager_secret_version.github_token.secret_data
  owner = var.github_owner
}