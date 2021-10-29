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
    key    = "profolio-website/prod/terraform.tfstate"
    region = "eu-west-1"
  }

}

provider "aws" {
  region = var.region
  profile = "devops"
}

provider "aws" {
//  certificate must be in us-east-1 to be used by cloudfront
  alias  = "acm_provider"
  profile = "devops"
  region = "us-east-1"
}