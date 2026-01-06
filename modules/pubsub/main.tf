module "pubsub" {
  source     = "terraform-google-modules/pubsub/google"
  version    = "~> 6.0"
  project_id = var.project_id
  topic      = var.topic

  pull_subscriptions = var.pull_subscriptions
  push_subscriptions = var.push_subscriptions
}
