provider "google" {
  credentials = jsondecode(base64decode(var.gcp_sa_key))
  project     = var.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-c"
}

variable "gcp_sa_key" {
  description = "Base64 encoded service account key for GCP"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}
