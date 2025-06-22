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

