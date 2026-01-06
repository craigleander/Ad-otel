output "names" {
  description = "Bucket names"
  value       = module.cloud_storage.names
}

output "urls" {
  description = "Bucket URLs"
  value       = module.cloud_storage.urls
}
