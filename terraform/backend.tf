terraform {
  backend "gcs" {
    bucket  = "terraform-state-test-gl5"
    prefix  = "terraform/state"
  }
}
