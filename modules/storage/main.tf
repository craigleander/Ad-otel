module "cloud_storage" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "~> 5.0"
  project_id = var.project_id
  names      = var.names
  prefix     = var.prefix
  location   = var.location
  versioning = var.versioning
}
