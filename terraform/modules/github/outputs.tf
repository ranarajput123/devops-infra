output "gitops_private_key" {
  value = tls_private_key.gitops_ssh_key.private_key_pem
}

output "gitops_public_key" {
  value = tls_private_key.gitops_ssh_key.public_key_openssh
}

output "charts_private_key" {
  value = tls_private_key.charts_ssh_key.private_key_pem
}

output "charts_public_key" {
  value = tls_private_key.charts_ssh_key.public_key_openssh
}

output "github_known_hosts" {
  value = local.github_known_hosts
}
