module "sql" {
  source           = "terraform-google-modules/sql-db/google//modules/postgresql"
  version          = "~> 18.0"
  project_id       = var.project_id
  name             = var.name
  database_version = var.database_version
  region           = var.region
  zone             = var.zone
  tier             = var.tier

  ip_configuration = {
    ipv4_enabled    = false
    private_network = var.network_self_link
  }
  
  deletion_protection = var.deletion_protection
}
