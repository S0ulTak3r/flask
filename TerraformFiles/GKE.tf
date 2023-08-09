# Define required Terraform and provider versions
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  # Backend configuration for Google Cloud Storage
  backend "gcs" {
    bucket = "my-terraform-state-bucket-flaskproject"
    prefix = "terraform/state"
  }
}

# Variable definitions to make the configuration more modular
variable "project_id" {
  description = "The ID of the Google Cloud project"
  default     = "vernal-tracer-393305"
}

variable "region" {
  description = "The Google Cloud region"
  default     = "me-west1"
}

variable "zone" {
  description = "The Google Cloud zone"
  default     = "me-west1-a"
}

# Provider configuration for Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Local values for constants or computations
locals {
  oauth_scopes = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring"
  ]
}

# VPC Network Configuration
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true

  lifecycle {
    ignore_changes = all
  }
}

# GKE Cluster Configuration
resource "google_container_cluster" "primary" {
  name                     = "cluster-flask2"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  network = google_compute_network.vpc_network.name
}

# GKE Node Pool Configuration
resource "google_container_node_pool" "primary" {
  name       = "default-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "g1-small"
    disk_size_gb = 30
    image_type   = "COS_CONTAINERD"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = local.oauth_scopes
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
