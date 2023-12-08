variable "env" {
  description = "environment in which the application is deployed"
  type        = string
}

variable "gcp_sa_key" {
  description = "Base64 encoded service account key for GCP"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}