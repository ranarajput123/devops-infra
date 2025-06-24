terraform {
  required_version = ">= 1.10.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.40.0"
    }
  }
}
