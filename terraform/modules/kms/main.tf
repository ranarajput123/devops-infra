resource "google_kms_key_ring" "key_ring" {
  name     = var.key_ring_name
  location = var.region
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = var.key_name
  key_ring = google_kms_key_ring.key_ring.id
}