output "api_server_endpoint" {
  value = module.gke.endpoint
}

output "b64_ca_cert" {
  value = module.gke.ca_certificate
}
