terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "vernal-tracer-393305"
  region  = "europe-north1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  
  project_id   = "vernal-tracer-393305"
  name         = "cluster-flask"
  region       = "europe-north1"

  network      = google_compute_network.vpc_network.name

  remove_default_node_pool = true
  initial_node_count       = 1

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
}
