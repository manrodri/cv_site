variable "profile" {

}

variable "region" {

}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "aws_route53_zone_id" {
  description = "zone-id of an exising route53 domain zone"
  type        = string
}

