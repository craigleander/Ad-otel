output "cluster_name" {
  description = "Cluster name"
  value       = module.gke.name
}

output "cluster_endpoint" {
  description = "Cluster endpoint"
  value       = module.gke.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster ca certificate (base64 encoded)"
  value       = module.gke.ca_certificate
  sensitive   = true
}

output "location" {
  description = "Cluster location"
  value       = module.gke.location
}
