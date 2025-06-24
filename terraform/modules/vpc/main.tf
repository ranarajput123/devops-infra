resource "google_compute_network" "vpc_network" {
  name                            = local.vpc_name
  auto_create_subnetworks         = false
  routing_mode                    = var.routing_mode
  description                     = "VPC network for ${var.env} environment"
  delete_default_routes_on_create = true

}


resource "google_compute_subnetwork" "private_subnet" {
  description = "Private subnet for ${var.env} environment"
  region      = var.region
  name        = "${local.vpc_name}-private-subnet"
  network     = google_compute_network.vpc_network.id

  ip_cidr_range            = local.private_subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = local.pods_cidr
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = local.services_cidr
  }

}
resource "google_compute_router" "router" {
  name    = "${var.env}-nat-router"
  network = google_compute_network.vpc_network.id
  region  = var.region

  depends_on = [google_compute_network.vpc_network]
}
resource "google_compute_router_nat" "nat" {
  name                               = "${var.env}-nat-config"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  enable_endpoint_independent_mapping = true

  depends_on = [google_compute_network.vpc_network]
}

# Add route because without it the NAT gateway will not be used for egress traffic
resource "google_compute_route" "egress_to_internet_via_nat" {
  name             = "allow-egress-via-nat"
  network          = google_compute_network.vpc_network.id
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  tags             = ["private"]

  depends_on = [google_compute_network.vpc_network]
}
