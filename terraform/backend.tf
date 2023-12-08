terraform {
  backend "gcs" {
    bucket  = "terraform-state-test"
    prefix  = "terraform/state"
  }
}
