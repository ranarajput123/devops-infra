locals {
  gcp_apis = [
    # "artifactregistry.googleapis.com",         # Artifact Registry API
    "cloudkms.googleapis.com",          # Cloud Key Management Service (KMS) API
    "container.googleapis.com",         # Kubernetes Engine API
    "iam.googleapis.com",               # Identity and Access Management (IAM) API
    "iamcredentials.googleapis.com",    # IAM Service Account Credentials API
    "secretmanager.googleapis.com",     # Secret Manager API
    "servicemanagement.googleapis.com", # Service Management API
    "storage-api.googleapis.com",       # Google Cloud Storage JSON API
    "storage-component.googleapis.com", # Cloud Storage
    "compute.googleapis.com",           # Compute Engine API
  ]
}
