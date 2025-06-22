variable "project" {
  description = "The ID of the project where the KMS key will be created."
  type        = string
}

variable "region" {
  description = "The region where the KMS key will be created."
  type        = string
}

variable "key_ring_name" {
  description = "The name of the KMS key ring."
  type        = string
}

variable "key_name" {
  description = "The name of the KMS key."
  type        = string
}