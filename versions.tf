terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region

  # Impersonate service account
  # impersonate_service_account = "leander-read-sva@leander-test-471809.iam.gserviceaccount.com"
}

provider "google-beta" {
  project = var.project_id
  region  = var.region

  # Impersonate service account
  # impersonate_service_account = "leander-read-sva@leander-test-471809.iam.gserviceaccount.com"
}
