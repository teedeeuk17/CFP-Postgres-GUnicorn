
data "docker_image" "local_image" {
  name = "g-unicorun_api_app"
}

resource "docker_container" "cfp_api" { 
  name  = "g-unicorun_api_app"
  image = data.docker_image.local_image.name  #
  ports {
    internal = 5000
    external = 5000
  }
}






# Find the latest Ubuntu precise image.
resource "docker_image" "ubuntu" {
  name = "ubuntu:precise"
}

resource "docker_image" "cfp_postgres" {
  name = "zoo"
  build {
    context = "."
    tag     = ["cfp_postgres:develop"]
    build_arg = {
      foo : "cfp_postgres"
    }
    label = {
      author : "tkerr"
    }
  }
}




resource "docker_container" "ubuntu" {
  name  = "g-unicorn"
  image = docker_image.ubuntu.image_id
}


module "sql-postgres" {
source         = "./terraform-modules/postgres"
#version      = "1.1.0"
resource_group_name  = ""
region               = ""
postgres_server_name = ""
admin_username       = ""
admin_password       = ""
postgre_db_name      = ""
}

module "api-gunicorn" {
source         = "./terraform-modules/api-gunicorn"
#version      = "1.1.0"
}