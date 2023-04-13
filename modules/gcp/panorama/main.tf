
# Retrieve zones.
data "google_compute_zones" "main" {
  project = var.project_id
  region  = var.region
}


# Create public IP address to attach to Panorama.
resource "google_compute_address" "static" {
  name = "${var.prefix}-panorama-ip"
}


# Create 2tb attachable disk for Panorama
resource "google_compute_disk" "this" {
  name = "${var.prefix}-compute-disk"
  zone = data.google_compute_zones.main.names[0]
  size = 2000
}


# Connect Panorama & disk
resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.this.id
  instance = google_compute_instance.panorama.id
}


# Create Panorama instance in the VPC subnetwork.
resource "google_compute_instance" "panorama" {
  name         = "${var.prefix}-panorama"
  machine_type = var.panorama_machine_type
  zone         = data.google_compute_zones.main.names[0]

  boot_disk {
    initialize_params {
      image = var.panorama_image_name
    }
  }

  network_interface {
    subnetwork = var.panorama_subnetwork
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    serial-port-enable = true
    ssh-keys           = fileexists(var.public_key_path) ? "admin:${file(var.public_key_path)}" : ""
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ]
  }
}

output "PANORAMA_IP" {
  value = google_compute_address.static.address
}