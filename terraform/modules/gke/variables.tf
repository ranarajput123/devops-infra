variable "region" {
  description = "The region where the GKE cluster will be created."
  type        = string
}
variable "env" {
  description = "The environment for the GKE cluster (e.g., nonprod, prod)."
  type        = string
}
variable "vpc_network_id" {
  description = "The ID of the VPC network to use for the GKE cluster."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to use for the GKE cluster."
  type        = string
}

variable "pods_cidr" {
  description = "value of the CIDR range for pods in the GKE cluster."
  type        = string
}

variable "services_cidr" {
  description = "value of the CIDR range for services in the GKE cluster."
  type        = string
}
