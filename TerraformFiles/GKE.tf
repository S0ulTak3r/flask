terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "vernal-tracer-393305"
  region  = "europe-north1"
}

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 15.0"

  name               = "cluster-flask"
  project_id         = "vernal-tracer-393305"
  region             = "europe-north1"
  network            = "default"
  subnetwork         = "default"
  release_channel    = "REGULAR"

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
    }
  ]

  ip_range_pods = "10.0.0.0/16"
  ip_range_services = "10.0.1.0/16"

  remove_default_node_pool = true
  enable_private_endpoint  = false
  enable_private_nodes     = false

  default_max_pods_per_node = 110
}
