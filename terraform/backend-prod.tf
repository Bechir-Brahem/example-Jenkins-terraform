terraform {
  backend "gcs" {
    bucket  = "terraform-state-prod-gl5"
    prefix  = "terraform/state/prod"
  }
}
