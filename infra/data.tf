# This data source looks up the public DNS zone
data "aws_route53_zone" "public" {
  name         = var.domain_name
  private_zone = false
}