variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
  default     = "gke-cluster"
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "zones" {
  description = "The zones to host the cluster in"
  type        = list(string)
}

variable "network_name" {
  description = "The name of the app VPC network"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the app subnetwork"
  type        = string
}

variable "ip_range_pods" {
  description = "The name of the secondary subnet ip range to use for pods"
  type        = string
}

variable "ip_range_services" {
  description = "The name of the secondary subnet ip range to use for services"
  type        = string
}

variable "service_account_email" {
  description = "The service account email to use for the node pool"
  type        = string
  default     = "default"
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}
