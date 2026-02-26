# Terraform MiniAzure 🐳

Local environment that simulates Azure services using Docker, Azurite, MinIO, and SQL Server Express. Great for development and testing without an active Azure subscription.

## What does it spin up?

| Service | Emulates | Description |
|---------|----------|-------------|
| **Azurite** | Azure Storage | Official Azure Blob, Queue and Table Storage emulator |
| **MinIO** | Azure Blob Storage | S3/Azure-compatible object storage |
| **SQL Server Express** | Azure SQL | Local relational database |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) running
- [AWS CLI](https://aws.amazon.com/cli/) (required by the AWS provider)

## Usage

**1. Clone the repository**
```bash
git clone https://github.com/hyrule-nexus1/Terraform-MiniAzure.git
cd Terraform-MiniAzure
```

**2. Initialize Terraform**
```bash
terraform init
```

**3. Preview changes before applying**
```bash
terraform plan
```

**4. Spin up the environment**
```bash
terraform apply
```

**5. Tear down the environment**
```bash
terraform destroy
```

## Providers

- [`hashicorp/aws`](https://registry.terraform.io/providers/hashicorp/aws) `~> 5.100`
- [`kreuzwerker/docker`](https://registry.terraform.io/providers/kreuzwerker/docker) `~> 2.23`

## Project structure

```
.
├── main.tf           # Main resources
├── variables.tf      # Project variables
├── outputs.tf        # Terraform outputs
├── .gitignore        # Excludes .terraform/, tfstate, etc.
└── README.md
```

## Notes

- `.tfvars` files are excluded from the repository for security reasons.
- Terraform state (`.tfstate`) is local and not pushed to the repo.
- This project is intended for local development environments only.
