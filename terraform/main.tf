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

  depends_on = [module.gcp]
}

module "gke_cluster" {
  source                 = "./modules/gke"
  region                 = var.region
  env                    = var.environment
  vpc_network_name       = module.vpc.vpc_name
  subnet_name            = module.vpc.subnet_name
  master_node_cidr       = module.vpc.master_node_cidr
  pods_cidr              = module.vpc.pods_cidr
  services_cidr          = module.vpc.services_cidr
  pods_ip_range_name     = module.vpc.pods_ip_range_name
  services_ip_range_name = module.vpc.services_ip_range_name
  project                = var.project

  depends_on = [module.gcp, module.vpc]
}

module "github" {
  source           = "./modules/github"
  environment      = var.environment
  gitops_repo_name = var.gitops_repo_name
  charts_repo_name = var.charts_repo_name
  project          = var.project

  depends_on = [module.gcp]
}

module "flux" {
  source                    = "./modules/flux"
  environment               = var.environment
  github_token              = data.google_secret_manager_secret_version.github_token.secret_data
  project                   = var.project
  charts_private_key_pem    = module.github.charts_private_key
  charts_public_key_openssh = module.github.charts_public_key
  github_known_hosts        = module.github.github_known_hosts

  providers = {
    flux       = flux
    kubernetes = kubernetes
  }

  depends_on = [module.gcp, module.github, module.gke_cluster]
}

# Just creating a single key for now due to learning purpose, can be extended later
module "kms" {
  source        = "./modules/kms"
  region        = var.region
  project       = var.project
  key_ring_name = "personal-ring"
  key_name      = "personal-key"

  depends_on = [module.gcp]
}

module "teams" {
  source          = "./modules/teams"
  project         = var.project
  frontend_devs   = []
  backend_devs    = []
  full_stack_devs = []

  depends_on = [module.gcp]
}
