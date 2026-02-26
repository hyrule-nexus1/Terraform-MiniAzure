#Crea el SQL  en un contenedor de Docker
terraform {
    required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1" # Esta versión es la "navaja suiza" de compatibilidad
    }
   }
resource "docker_container" "mysql" {
	name  = var.nombre_contenedor
	image = "mcr.microsoft.com/mssql/server:2019-latest"

	#Conectar a la red creada por Network
	networks_advanced { 
		name = var.id_vred
		}

	#Password desde el secret file de Docker
	env = [
		"ACCEPT_EULA=Y",
		"SA_PASSWORD_FILE=run/secrets/sql_password"
	]
	
	#Abrir puertos SQL
	ports {
		internal = 1433
		external = 1433
	}
}