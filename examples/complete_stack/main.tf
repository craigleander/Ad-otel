module "complete_stack" {
  source = "../../"

  project_id = "example-project-id"
  region     = "us-central1"
  zone       = "us-central1-a"
}
