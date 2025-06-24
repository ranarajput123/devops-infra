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
