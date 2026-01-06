output "topic" {
  description = "The topic name"
  value       = module.pubsub.topic
}

output "id" {
  description = "The topic ID"
  value       = module.pubsub.id
}

output "uri" {
  description = "The topic URI"
  value       = module.pubsub.uri
}

output "subscription_names" {
  description = "The subscription names"
  value       = module.pubsub.subscription_names
}
