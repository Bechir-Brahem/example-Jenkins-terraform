variable "repo_url" {
  description = "The URL of the Git repository"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
}

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

resource "google_compute_instance" "monitoring" {
  name         = "monitoring-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y curl tar apt-transport-https software-properties-common wget

    # Install Prometheus
    curl -LO "https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz"
    tar -xvf prometheus-2.30.0.linux-amd64.tar.gz
    cd prometheus-2.30.0.linux-amd64
    nohup ./prometheus &

    # Install Grafana
    wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install -y grafana
    sudo systemctl start grafana-server
  EOT

  tags = ["monitoring-server"]
}

resource "google_compute_firewall" "monitoring_firewall" {
  name    = "allow-monitoring"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9090", "3000"] # Prometheus and Grafana ports
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["monitoring-server"]
}
