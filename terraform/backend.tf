terraform {
  backend "gcs" {
    bucket  = "terraform-state-${var.env}-gl5"
    prefix  = "terraform/state"
  }
}
