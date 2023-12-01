resource "google_cloud_run_v2_service" "default" {
  name     = "django-app"
  location = var.region
  client   = "terraform"
  project  = var.project_id

  template {
    containers {
      image = "europe-west1-docker.pkg.dev/tp-4-gl5/django-app/django-app:latest"
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


