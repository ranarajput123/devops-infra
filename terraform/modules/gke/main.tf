resource "google_container_cluster" "primary" {
  name     = "${var.env}-gke-cluster"
  location = var.region

  initial_node_count = 1
  node_config {
    machine_type = "e2-micro"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  network    = var.vpc_network_id
  subnetwork = var.subnet_id

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_ip_range_name
    services_secondary_range_name = var.services_ip_range_name
  }

  cost_management_config {
    enabled = true
  }
}
