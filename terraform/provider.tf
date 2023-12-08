provider "google" {
  credentials = jsondecode(base64decode(var.gcp_sa_key))
  project     = var.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-c"
}
