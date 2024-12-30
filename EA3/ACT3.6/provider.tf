terraform {
  required_version = ">= 1.8.0, < 2.0.0"

  # DESCOMENTAR
  # backend "remote" {
  #   organization = "TU_ORGANIZACION"

  #   workspaces {
  #     name = "TU_WORKSPACE"
  #   }
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.6"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# DESCOMENTAR
# provider "hcp" {
#     token = var.hcp_api_token
# }
