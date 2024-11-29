terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.73.0"
    }
    tls = {
       source = "hashicorp/tls"
       version = "4.0.6"
     }
  }
}

provider "aws" {
  # Configuration de Prueba
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_KEY_ID
}

provider "tls" {
  # Configuration options
}

