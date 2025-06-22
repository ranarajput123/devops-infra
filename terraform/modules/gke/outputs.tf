output "api_server_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "b64_ca_cert" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}