terraform {
    required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1" # Esta versión es la "navaja suiza" de compatibilidad
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

backend "s3" {
    bucket                      = "tfstate"
    key                         = "dev/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://127.0.0.1:9000" 
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}

provider "aws" {
  access_key = var.minio_access_key
  secret_key = var.minio_secret_key
  region     = "us-east-1"

  endpoints {
    s3 = "http://localhost:9000"
  }
  # Evitan llamadas a STS / validaciones que MinIO no soporta
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  # Compatibilidad con MinIO
  s3_use_path_style = true
}
module "network" {
  source      = "./modules/network"
  nombre_vred = "docker_network3"
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
  # Borra cualquier línea de api_version aquí
}

# 2. Módulo de Storage (MinIO)
module "storage" {
  source = "./modules/storage"

  # Pasamos las variables que definiste en el módulo
  nombre_contenedor = "minio-terraform"
  id_vred           = module.network.id_vred
  ruta_datos        = "C:/Users/Aldo/DevOps/data/minio" # Ajusta esta ruta a tu PC
}

# 3. Módulo SQL (Opcional por ahora, pero aquí iría)
# module "sql" {
#   source = "./modules/sql"
#   ...
# }