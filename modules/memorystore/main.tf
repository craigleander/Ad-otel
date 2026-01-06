module "memorystore" {
  source             = "terraform-google-modules/memorystore/google"
  version            = "~> 7.0"
  project            = var.project_id
  name               = var.name
  region             = var.region
  tier               = var.tier
  memory_size_gb     = var.memory_size_gb
  authorized_network = var.authorized_network
  redis_version      = var.redis_version
}
