resource "google_cloud_run_service" "default" {
  name     = "django-app-service-test"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project_id}/your-app-test"  # Replace with your image path
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Set the Cloud Run service to be publicly accessible
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = var.gcp_project_id
  service     = google_cloud_run_service.default.name

  policy_data = <<EOF
    {
    "bindings": [
        {
        "role": "roles/run.invoker",
        "members": [
            "allUsers"
        ]
        }
    ]
    }
  EOF
}

