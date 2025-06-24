resource "google_service_account" "red_pool_service_account" {
  account_id   = "red-pool-sa"
  display_name = "red-pool-service-account"
}

resource "google_iam_custom_role" "gke_node_pool_sa_role" {
  role_id     = "GKENodePoolSARole"
  title       = "GKE Node Pool SA Role"
  description = "Custom role for GKE node pool service account"
  permissions = local.node_pool_sa_permissions
}

resource "google_project_iam_member" "red_node_pool_sa_role_binding" {
  project = var.project
  role    = google_iam_custom_role.gke_node_pool_sa_role.id
  member  = "serviceAccount:${google_service_account.red_pool_service_account.email}"
}
