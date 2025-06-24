output "gke_api_server_endpoint" {
  description = "The API server endpoint of the GKE cluster"
  value       = "https://${module.gke_cluster.api_server_endpoint}"
}

output "cluster_ca_cert" {
  value = module.gke_cluster.b64_ca_cert
}
