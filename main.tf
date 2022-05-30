terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.22.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "my-lab-project-01-0527"
  region = "us-central1"
  zone = "us-central1-a"

resource "google_compute_instance" "gcplab-tf-vm" {
  name = "gcplab-tf-vm-01"
  zone = "us-west1-a"
  machine_type = "e2-medium"

  tags = ["http-server", "https-server"]
  
  allow_stopping_for_update = true

  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {

    }
  }

# metadata_startup_script = file("./apache.sh")

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220519"
      size = 10
      
    }
    auto_delete = true
  }

  labels = {
    "env" = "testing"
    "type" = "tf-managed"
  }

  
  scheduling {
    preemptible = false
    automatic_restart = false
  }
  
  service_account {
    email = "939790744174-compute@developer.gserviceaccount.com"
    scopes = [ "cloud-platform" ]
  }

  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }

}

### Create additional disk
#resource "google_compute_disk" "default" {
#  name = "compute-disk"
#  zone = "us-west1-a"
#  size = 5
#  size = 15
#}

### Attach additional disk to VM
#resource "google_compute_attached_disk" "default" {
#  disk     = google_compute_disk.default.id
#  instance = google_compute_instance.gcplab-tf-vm.id
#}
#
