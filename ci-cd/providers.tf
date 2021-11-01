terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

   backend "s3" {
    bucket = "manrodri.com-terraform"
    profile = "devops"
    key    = "profolio-website/prod/ci-cd/terraform.tfstate"
    region = "eu-west-1"
  }

}

provider "aws" {
  region = var.region
  profile = "devops"
}