terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
features {
resource_group {
prevent_deletion_if_contains_resources = false
     }
  }
}


provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

# Create a container
resource "docker_container" "postgres" {
  image = docker_image.ubuntu.image_id
  name  = "cfp-postgres"
}