provider "google" {
  project = var.project_id
  region  = var.region
}


module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 15.0"

  project_id   = var.project_id
  name         = "cluster-flask"
  region       = var.region
  network      = "default"
  subnetwork   = "default"

  release_channel = "REGULAR"  // Stable versions with some delay

  node_pools = [
    {
      name               = "default-pool"
      machine_type       = "n1-g1-small"
      min_count          = 1
      max_count          = 1
      disk_size_gb       = 80
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    }
  ]

  ip_range_services = "10.0.0.0/16"
  ip_range_pods = "10.0.1.0/16"

  node_pools_additional_zones = []
}

variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
  default     = "vernal-tracer-393305"
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
  default     = "europe-north1"
}