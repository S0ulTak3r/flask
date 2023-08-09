terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket = "my-terraform-state-bucket-flaskproject"
    prefix = "terraform/state"
  }
}

provider "google" {
  project     = "vernal-tracer-393305"
  region      = "me-west1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true

  lifecycle {
    ignore_changes = all
  }
}

resource "google_container_cluster" "primary" {
  name     = "cluster-flask2"
  location = "me-west1-a"  # Set the location to me-west1-a

  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  network    = google_compute_network.vpc_network.name
}

resource "google_container_node_pool" "primary" {
  name       = "default-pool"
  location   = "me-west1-a"  # Set the location to me-west1-a
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "g1-small"
    disk_size_gb = 30  # Reduced to 30 GB
    image_type = "COS_CONTAINERD"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
