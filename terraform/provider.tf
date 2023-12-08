provider "google" {
  credentials = jsondecode(base64decode(var.gcp_sa_key))
  project     = var.gcp_project_id
  region      = "europe-west3"
  zone        = "europe-west3-a"
}
