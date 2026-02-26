# Crea un contenedor con la imagen de MINIO para Docker
# Secrets leidos desde docker secrets

terraform {
    required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1" # Esta versión es la "navaja suiza" de compatibilidad
    }
}
}
resource "docker_container" "minio2" {
  #name  = var.nombre_contenedor
  name  = var.nombre_contenedor
  image = "minio/minio"
  
  # Inicializar minio, levanta MINIO
  command = ["server", "/data", "--console-address", ":9001"]

  # Conectar la imagen de MinIO a la red de Docker
  networks_advanced {
    name = var.id_vred
  }
  # --- TODO LO DE ABAJO DEBE IR DENTRO DEL RECURSO ---
    # Variables de entorno usando secrets montados por docker 
  # FALTA: Coma entre los elementos de la lista
  env = [
    "MINIO_ROOT_USER_FILE=/run/secrets/minio_root_user",
    "MINIO_ROOT_PASSWORD_FILE=/run/secrets/minio_root_password"
  ]

  # Abrir puertos
  ports {
    internal = 9001
    external = 9001
  }
  ports {
    internal = 9000
    external = 9000
  }

  # Volumen de persistencia
  volumes {
    container_path = "/data"
    host_path      = var.ruta_datos
  }
}