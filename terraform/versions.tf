terraform {
  required_version = ">= 1.10.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.40.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.41.0"
    }

    flux = {
      source  = "fluxcd/flux"
      version = "1.6.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }

    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}
