variable "project" {
  type = string
}
variable "region" {
  description = "The region where the GKE cluster will be created."
  type        = string
}
variable "env" {
  description = "The environment for the GKE cluster (e.g., nonprod, prod)."
  type        = string
}
variable "vpc_network_name" {
  description = "The name of the VPC network to use for the GKE cluster."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet to use for the GKE cluster."
  type        = string
}

variable "master_node_cidr" {
  description = "The CIDR range for master nodes in the GKE cluster."
  type        = string
}
variable "pods_ip_range_name" {
  description = "The name of the secondary range for pods in the GKE cluster."
  type        = string
}

variable "pods_cidr" {
  description = "value of the CIDR range for pods in the GKE cluster."
  type        = string
}

variable "services_ip_range_name" {
  description = "The name of the secondary range for services in the GKE cluster."
  type        = string
}

variable "services_cidr" {
  description = "value of the CIDR range for services in the GKE cluster."
  type        = string
}
