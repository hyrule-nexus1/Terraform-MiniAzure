terraform {
    required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1" # Esta versión es la "navaja suiza" de compatibilidad
    }
   }
}
resource "docker_network" "vred_local" {
	name = var.nombre_vred
    check_duplicate = false 
    attachable      = true
}

