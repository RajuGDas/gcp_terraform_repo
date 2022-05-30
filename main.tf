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
}

resource google_storage_bucket "mlpgs01"{
  name = "mlpgs01-bucket01-0529001"
  location = "us-central1"
}










