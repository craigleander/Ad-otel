output "secret_names" {
  description = "List of secret names"
  value       = module.secret_manager.secret_names
}

output "secret_versions" {
  description = "List of secret versions"
  value       = module.secret_manager.secret_versions
}
