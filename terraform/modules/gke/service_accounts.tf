resource "google_service_account" "red_pool_service_account" {
  account_id   = "red-pool-sa"
  display_name = "red-pool-service-account"
}

resource "google_project_iam_custom_role" "gke_node_pool_sa_role" {
  role_id     = "GKENodePoolSACustomRole"
  title       = "GKE Node Pool SA Custom Role"
  description = "Custom role for GKE node pool service account"
  permissions = local.node_pool_sa_additional_permissions
}

resource "google_project_iam_member" "red_pool_sa_logging" {
  project = var.project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.red_pool_service_account.email}"
}

resource "google_project_iam_member" "red_pool_sa_monitoring" {
  project = var.project
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.red_pool_service_account.email}"
}

resource "google_project_iam_member" "red_pool_sa_container_node" {
  project = var.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.red_pool_service_account.email}"
}
resource "google_project_iam_member" "red_node_pool_sa_role_binding" {
  project = var.project
  role    = google_project_iam_custom_role.gke_node_pool_sa_role.id
  member  = "serviceAccount:${google_service_account.red_pool_service_account.email}"
}
