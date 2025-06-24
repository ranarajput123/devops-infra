resource "google_project_service" "api" {
  for_each = toset(local.gcp_apis)
  project  = var.project
  service  = each.value

  disable_on_destroy = false
}


