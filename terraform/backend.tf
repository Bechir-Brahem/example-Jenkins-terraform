terraform {
  backend "gcs" {
    bucket  = "terraform-state-${terraform.workspace}-gl5"
    prefix  = "terraform/state/${terraform.workspace}"
  }
}
