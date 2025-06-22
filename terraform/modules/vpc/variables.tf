variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
}
variable "env" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
}
variable "routing_mode" {
  description = "The routing mode for the VPC (e.g., GLOBAL, REGIONAL)"
  type        = string
  default     = "REGIONAL"
}

variable "region" {
  description = "The region where the VPC will be created"
  type        = string
}

variable "vpc_main_cidr" {
  description = "The CIDR block for the VPC network (e.g., 10.0.0.0/16)"
  type        = string
}
