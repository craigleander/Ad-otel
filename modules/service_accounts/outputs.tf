output "email" {
  description = "The email address of the service account"
  value       = module.service_accounts.email
}

output "iam_email" {
  description = "The IAM-format email address of the service account"
  value       = module.service_accounts.iam_email
}

output "service_account" {
  description = "The service account resource"
  value       = module.service_accounts.service_account
}
