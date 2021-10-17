##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}


