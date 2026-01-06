module "secret_manager" {
  source     = "git::https://github.com/GoogleCloudPlatform/terraform-google-secret-manager.git" 
  # Actually, the user linked https://github.com/GoogleCloudPlatform/terraform-google-secret-manager
  # which usually maps to "GoogleCloudPlatform/secret-manager/google" on registry.
  project_id = var.project_id
  secrets    = var.secrets
}
