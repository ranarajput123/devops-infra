
# allow inbound health_checks rule that applies to all VMs. Allow ingress for GCP LB health checks.
resource "google_compute_firewall" "allow_health_check_ingress" {
  name    = "allow-hc-ingress"
  network = google_compute_network.vpc_network.network_id
  #    .network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] // GCP LB health check IP ranges
  priority      = 990

  depends_on = [google_compute_network.vpc_network]
}

# allow outbound health_checks rule that applies to all VMs. Allow egress for GCP LB health checks.
resource "google_compute_firewall" "allow_health_check_egress" {
  name    = "allow-hc-egress"
  network = google_compute_network.vpc_network.network_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction          = "EGRESS"
  destination_ranges = ["130.211.0.0/22", "35.191.0.0/16"] // GCP LB health check IP ranges
  priority           = 990

  depends_on = [module.net]
}

# # # # # #  Private subnet fire-walling. Allow all traffic within the private subnet, deny all traffic from outside the private subnet, and allow egress to the internet. # # # # # # #
resource "google_compute_firewall" "allow_private_subnet" {
  name    = "allow-private-subnet"
  network = google_compute_network.vpc_network.network_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8"]
  target_tags   = ["private"]
  priority      = 990

  depends_on = [google_compute_network.vpc_network.network_id]
}

resource "google_compute_firewall" "deny_access_private_subnet" {
  name    = "deny-access-private-subnet"
  network = google_compute_network.vpc_network.network_id

  deny {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["private"]
  priority      = 1010

  depends_on = [google_compute_network.vpc_network.network_id]
}

resource "google_compute_firewall" "allow_internet_egress_private_subnet" {
  name    = "allow-internet-private-subnet"
  network = google_compute_network.vpc_network.network_id

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["private"]
  priority           = 990

  depends_on = [google_compute_network.vpc_network.network_id]
}
