resource "google_kms_key_ring" "infra_key_ring" {
  name     = "devops-learning-key-ring"
  location = var.region
}

resource "google_kms_crypto_key" "infra_crypto_key" {
  name     = "devops-learning-crypto-key"
  key_ring = google_kms_key_ring.infra_key_ring.id
}