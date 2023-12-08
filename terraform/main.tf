resource "google_cloud_run_service" "default" {
  name     = "django-app-service-test"
  location = "europe-west3"

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project_id}/your-app-test"  # Replace with your image path
        ports {
          container_port = 8000
        }   
      }
    }
  }

  traffic {
    percent         = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

# Set the Cloud Run service to be publicly accessible
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = var.gcp_project_id
  name     = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

