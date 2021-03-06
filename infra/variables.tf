variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "devops"
}

variable "domain_name" {
  type = string
  default = "manrodri.com"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "manrodri.com"
}

############## local variables ###############

locals {
  common_tags = {
    "Team" : "Cloud and Hosting",
    "Lead Engineer" : "Manuel Rodriguez",
    "Application Lead" : "Manuel Rodriguez"
    "Project": "portfolio website"
  }
}


