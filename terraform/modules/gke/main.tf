resource "google_container_cluster" "primary" {
  name     = "${var.env}-gke-cluster"
  location = "europe-west1-b"

  deletion_protection      = false
  remove_default_node_pool = true

  initial_node_count = 1
  workload_identity_config {
    workload_pool = local.gke_identity_pool
  }

  node_config {
    tags = ["private"]
  }
  node_pool_auto_config {
    network_tags {
      tags = ["private", "gke-node"]
    }
  }
  vertical_pod_autoscaling {
    enabled = true
  }
  network    = var.vpc_network_id
  subnetwork = var.subnet_id

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "STABLE"
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_node_cidr
  }
  # master_authorized_networks_config {
  #   dynamic "cidr_blocks" {
  #     for_each = local.ovo_vpn_ip_ranges
  #     content {
  #       cidr_block   = cidr_blocks.value
  #       display_name = "Authorized Network"
  #     }

  #   }
  # }
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_ip_range_name
    services_secondary_range_name = var.services_ip_range_name
  }

  cost_management_config {
    enabled = true
  }
}
resource "google_container_node_pool" "default" {
  name     = "red-pool"
  cluster  = google_container_cluster.primary.name
  location = "europe-west1-b"

  node_config {
    machine_type    = "e2-medium"
    service_account = google_service_account.red_pool_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    preemptible = true
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    tags = ["private", "prv-gke-node"]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
