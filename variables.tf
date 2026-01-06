variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "leander-test-471809"
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone to deploy to"
  type        = string
  default     = "us-central1-a"
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
