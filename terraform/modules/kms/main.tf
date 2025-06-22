resource "google_kms_key_ring" "infra_key_ring" {
  name     = "infra-key-ring"
  location = var.region
}

resource "google_kms_crypto_key" "infra_crypto_key" {
  name     = "infra-crypto-key"
  key_ring = google_kms_key_ring.infra_key_ring.id
}