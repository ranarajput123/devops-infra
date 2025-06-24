module "gcp" {
  source = "./modules/gcp"

  project     = var.project
  environment = var.environment
}
module "vpc" {
  source        = "./modules/vpc"
  vpc_name      = "learning-dev-ops"
  region        = var.region
  env           = var.environment
  routing_mode  = "REGIONAL"
  vpc_main_cidr = "10.0.0.0/16"
}

module "gke_cluster" {
  source                 = "./modules/gke"
  region                 = var.region
  env                    = var.environment
  vpc_network_id         = module.vpc.vpc_id
  subnet_id              = module.vpc.subnet_id
  pods_cidr              = module.vpc.pods_cidr
  services_cidr          = module.vpc.services_cidr
  pods_ip_range_name     = module.vpc.pods_ip_range_name
  services_ip_range_name = module.vpc.services_ip_range_name
}

module "flux" {
  source              = "./modules/flux"
  api_server_endpoint = "https://${module.gke_cluster.api_server_endpoint}"
  b64_ca_cert         = base64decode(module.gke_cluster.b64_ca_cert)
  charts_repo_name    = var.charts_repo_name
  environment         = var.environment
  gcp_access_token    = data.google_client_config.default.access_token
  github_owner        = var.github_owner
  gitops_repo_name    = var.gitops_repo_name
  github_token        = data.google_secret_manager_secret_version.github_token.secret_data
  project             = var.project

  # depends_on = [module.gke_cluster, data.google_client_config.default]
}

# Just creating a single key for now due to learning purpose, can be extended later
module "kms" {
  source        = "./modules/kms"
  region        = var.region
  project       = var.project
  key_ring_name = "devops-learning-key-ring"
  key_name      = "devops-learning-crypto-key"
}

module "teams" {
  source          = "./modules/teams"
  project         = var.project
  frontend_devs   = []
  backend_devs    = []
  full_stack_devs = []
}

resource "tls_private_key" "gitops_ssh_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "gitops_deploy_key" {
  repository = var.gitops_repo_name
  title      = "Flux Git ops Deploy Key"
  key        = tls_private_key.gitops_ssh_key.public_key_openssh
  read_only  = false
}
