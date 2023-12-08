resource "google_cloud_run_v2_service" "default" {
  name     = "django-app-${var.env}"
  location = "europe-west3"
  client   = "terraform"
  project  = var.gcp_project_id

  template {
    containers {
      image = "gcr.io/${var.gcp_project_id}/your-app-${var.env}"
        ports {
          container_port = 8000
        }    
}
  }
  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"

  }

}

resource "google_cloud_run_v2_service_iam_member" "noauth" {
  project = "tp-4-gl5"
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}


