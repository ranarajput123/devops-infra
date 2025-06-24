locals {
  ovo_vpn_ip_ranges = [
    "104.30.132.42/32",
    "104.30.132.43/32",
    "104.30.132.44/32",
    "104.30.132.45/32",
    "104.30.132.46/32",
    "104.30.132.49/32",
    "104.30.132.50/32",
    "104.30.132.51/32",
    "104.30.132.52/32",
    "104.30.132.53/32",
    "104.30.132.54/32",
    "104.30.132.55/32",
    "104.30.132.56/32",
    "104.30.132.57/32",
    "104.30.132.58/32",
    "104.30.132.59/32",
    "104.30.132.60/32",
    "104.30.132.67/32",
    "104.30.132.68/32",
    "104.30.134.19/32",
  ]

  node_pool_sa_permissions = [
    "artifactregistry.dockerimages.get",
    "artifactregistry.dockerimages.list",
    "artifactregistry.repositories.downloadArtifacts",
    "autoscaling.sites.writeMetrics",
    "logging.logEntries.create",
    "monitoring.metricDescriptors.list",
    "monitoring.timeSeries.create",
    "storage.objects.get",
    "storage.objects.list",
  ]

  gke_identity_pool = "${var.project}.svc.id.goog"

}
