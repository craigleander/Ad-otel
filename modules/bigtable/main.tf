module "bigtable" {
  source     = "git::https://github.com/GoogleCloudPlatform/terraform-google-bigtable.git"
  project_id = var.project_id
  name       = var.name
  zones               = var.zones
  tables              = var.tables
  deletion_protection = var.deletion_protection
}
