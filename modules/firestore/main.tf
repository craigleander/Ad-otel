resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = var.database_id
  location_id = var.location
  type                    = var.type
  deletion_policy         = var.deletion_policy
  delete_protection_state = var.delete_protection_state
}
