output "host" {
  description = "The IP address of the instance"
  value       = module.memorystore.host
}

output "port" {
  description = "The port number of the instance"
  value       = module.memorystore.port
}

output "id" {
  description = "The memorystore instance ID"
  value       = module.memorystore.id
}
