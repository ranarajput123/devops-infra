output "region" {
  description = "The region where the VPC and subnet are created"
  value       = var.region
}

output "vpc_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.vpc_network.id
}

output "subnet_name" {
  description = "The name of the private subnet"
  value       = google_compute_subnetwork.private_subnet.name
}

output "subnet_id" {
  description = "The ID of the private subnet"
  value       = google_compute_subnetwork.private_subnet.id
}

output "subnet_cidr" {
  description = "The CIDR range of the private subnet"
  value       = google_compute_subnetwork.private_subnet.ip_cidr_range
}

output "pods_cidr" {
  description = "The CIDR range for pods in the private subnet"
  value       = google_compute_subnetwork.private_subnet.secondary_ip_range[0].ip_cidr_range
}

output "services_cidr" {
  description = "The CIDR range for services in the private subnet"
  value       = google_compute_subnetwork.private_subnet.secondary_ip_range[1].ip_cidr_range
}

