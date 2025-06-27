module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "37.0.0"

  name       = "${var.env}-gke-cluster"
  project_id = var.project
  region     = var.region
  cluster_resource_labels = {
    private-cluster = "true"
  }
  monitoring_enable_managed_prometheus = false

  deletion_protection = false
  network             = var.vpc_network_name
  # The subnetwork to use for the GKE cluster, which is used for pod and service networking
  subnetwork = var.subnet_name



  # The Kubernetes version to use for the GKE cluster. This should be updated to the latest supported version.
  kubernetes_version = "1.32"

  release_channel = "STABLE" # The release channel for the GKE cluster, which determines the version and stability of the cluster. STABLE is the recommended channel for production clusters.

  # Set to true if you want a regional cluster, false for a zonal cluster.
  regional = false

  zones = [
    "europe-west1-b"
  ]

  # Remove the default node pool created by GKE, as we will define our own node pools.
  remove_default_node_pool = true
  # Add firewall rules to allow access to the GKE master endpoint from the specified IP ranges.
  add_master_webhook_firewall_rules = true

  # We create a service account in the gke_service_account module and provide it here to have more control over the permissions and roles assigned to it.
  create_service_account = false

  # Enable private nodes for the GKE cluster, which means the nodes will not have public IP addresses and are not directly accessible from the internet.
  enable_private_nodes = true

  # Enable horizontal pod autoscaling for the GKE cluster, which allows pods to scale based on CPU utilization or other select metrics.
  horizontal_pod_autoscaling = true
  # Enable vertical pod autoscaling for the GKE cluster, which allows pods to automatically adjust their resource requests based on usage.
  enable_vertical_pod_autoscaling = true

  # Enable HTTP load balancing for the GKE cluster, which allows you to use GCP's global load balancer to distribute traffic to your pods and assign a public IP address to the cluster.
  http_load_balancing = true

  # The namespace for the GKE identity pool, which is used for Workload Identity. This allows Kubernetes service accounts to act as Google Cloud service accounts.
  identity_namespace = local.gke_identity_pool

  # The name of the IP range for pods in the GKE cluster, which is used for pod networking.
  ip_range_pods = var.pods_ip_range_name
  # The name of the IP range for services in the GKE cluster, which is used for service networking.
  ip_range_services = var.services_ip_range_name

  # The CIDR block for the GKE master node, which is used for the control plane networking.
  master_ipv4_cidr_block = var.master_node_cidr

  # Enable network policy for the cluster which kind of works like a firewall for pods. Like which pod can talk to which pod.
  network_policy = true


  master_global_access_enabled = false # This setting controls whether the GKE master endpoint is accessible from outside the cluster's region. Setting it to false means the master endpoint is only accessible from within the cluster's region, enhancing security by limiting access to the control plane.

  node_pools = [
    {
      service_account = google_service_account.red_pool_service_account.email
      auto_repair     = true
      # Enable autoscaling for the node pool, which allows the number of nodes in the pool to automatically adjust based on resource usage.
      auto_upgrade = true
      # Maximum number of nodes in the node pool, which is used for autoscaling.
      autoscaling = true
      # Minimum number of nodes in the node pool, which is used for autoscaling.
      max_count = 2
      # The image type for the node pool, which is the recommended image type for GKE clusters.Container optimised OS with containerd is the default and recommended image type for GKE clusters.
      min_count = 1
      # Initial number of nodes in the node pool, which is used for the first deployment of the cluster.
      image_type = "COS_CONTAINERD"
      # The machine type for the node pool, which determines the CPU and memory resources available to the nodes. e2-medium is a cost-effective machine type for GKE clusters.
      initial_node_count = 1
      # The name of the node pool, which is used to identify the pool within the cluster.
      machine_type = "e2-medium"
      # The zone or region where the node pool is located, which determines the physical location of the nodes. This should match the region of the GKE cluster.
      name = "red-pool"
      # Use preemptible VMs for the node pool, which are cost-effective but can be terminated by GCP at any time. This is useful for non-critical workloads that can tolerate interruptions.
      node_locations = "europe-west1-b"
      # The service account to use for the node pool, which allows the nodes to access GCP resources. We create a service account in the gke_service_account module and provide it here to have more control over the permissions and roles assigned to it.
      preemptible = true
    }
  ]
  # Use the GKE metadata server for node metadata, which is the recommended setting for GKE clusters, this is to enable Workload Identity in the cluster.
  node_metadata = "GKE_METADATA_SERVER"
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/drive",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  node_pools_tags = { "red-pool" : ["private", "prv-gke-node"] } # KEY = pool name, VALUE = list of tags for the node pool. Tags for the node pools, which can be used for filtering and grouping resources within the cluster. This is useful for organizing resources by team, environment, or application.


  # Enable Config Connector for the GKE cluster, which allows you to manage GCP resources using Kubernetes-style APIs.
  # config_connector                  = true 

  # The Pub/Sub topic to use for GKE notifications, which allows you to receive notifications about cluster events.
  # notification_config_topic       = google_pubsub_topic.gke_notifications.id 

  # IP ranges for master authorized networks, which allows you to restrict access to the GKE master endpoint to specific IP ranges. This is useful for securing the control plane of the cluster.
  # master_authorized_networks = [
  #   for ip in local.ovo_ips :
  #   { "cidr_block" = ip, "display_name" = "" }
  # ]

  # Stub domains for the cluster, which allows you to resolve DNS queries for specific domains using custom DNS servers. This is useful for internal services that are not exposed to the public internet.
  # stub_domains = {
  #   "ovoenergy.local" = ["10.60.111.237", "10.36.111.237"]
  # } 

  # Labels for the node pools, which can be used for filtering and grouping resources within the cluster. This is useful for organizing resources by team, environment, or application.
  # node_pools_labels = {
  # } 

  # Taints for the node pools, which are used to control which pods can be scheduled on the nodes in the pool. This is useful for isolating workloads or preventing certain pods from being scheduled on specific nodes.
  # only works with beta-private-cluster
  # node_pools_taints = {
  #  
  # } 

  # node_pools_metadata = {
  #  
  # }

  # additional_ip_range_pods = var.secondary_ipv4_ranges

  # Set to false because we create a service account in the gke_service_account module and provide it here to have more control over the permissions and roles assigned to it.
  # service_account                 = false 
}
