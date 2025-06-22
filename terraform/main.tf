module "vpc" {
  source        = "./modules/vpc"
  vpc_name      = "learning-dev-ops"
  region        = var.region
  env           = var.environment
  routing_mode  = "REGIONAL"
  vpc_main_cidr = "10.0.0.0/16"
}

module "gke_cluster" {
  source         = "./modules/gke"
  region         = var.region
  env            = var.environment
  vpc_network_id = module.vpc.vpc_id
  subnet_id      = module.vpc.subnet_id
  pods_cidr      = module.vpc.pods_cidr
  services_cidr  = module.vpc.services_cidr
}

module "flux" {
  source              = "./modules/flux"
  api_server_endpoint = module.gke_cluster.api_server_endpoint
  b64_ca_cert         = module.gke_cluster.b64_ca_cert
  charts_repo_name    = "devops-charts"
  environment         = var.environment
  gcp_access_token    = data.google_client_config.default.access_token
  github_owner        = "ranarajput"
  gitops_repo_name    = "devops-gitops"
  github_token        = data.google_secret_manager_secret_version.github_token.secret
  project             = var.project
}

module "teams" {
  source          = "./modules/teams"
  project         = var.project
  frontend_devs   = []
  backend_devs    = []
  full_stack_devs = []
}

# Just creating a single key for now due to learning purpose, can be extended later
module "kms" {
  source        = "./modules/kms"
  region        = var.region
  project       = var.project
  key_ring_name = "devops-learning-key-ring"
  key_name      = "devops-learning-crypto-key"
}

