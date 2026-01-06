output "instance_name" {
  description = "The instance name"
  value       = module.sql.instance_name
}

output "instance_connection_name" {
  description = "The connection name of the master instance to be used in connection strings"
  value       = module.sql.instance_connection_name
}

output "instance_ip_address" {
  description = "The IPv4 address assigned for the master instance"
  value       = module.sql.instance_ip_address
}
