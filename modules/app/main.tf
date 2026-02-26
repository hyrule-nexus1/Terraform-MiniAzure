# Crea un contenedor Nginx que simula un App Service
resource "docker_container" "app" {
  name  = var.nombre_contenedor
  image = "nginx:latest"

  # Conectar a la red creada por el modulo network
  networks_advanced {
    name = var.id_red
  }

  # Exponer puerto HTTP
  ports {
    internal = 80
    external = var.puerto_externo
  }

  # Montar un archivo index.html personalizado
  volumes {
    host_path      = "${path.module}/files"
    container_path = "/usr/share/nginx/html"
  }
}