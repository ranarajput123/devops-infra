terraform {
  required_version = ">= 1.10.4"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.41.0"
    }
  }
}
