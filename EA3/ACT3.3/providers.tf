terraform {
  backend "remote" {
    organization = "ignaciov1-org"
    workspaces {
      name = "act33-workspace"
    }
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}