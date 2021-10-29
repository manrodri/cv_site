
resource "aws_route53_record" "root-a" {
  zone_id = data.aws_route53_zone.public.id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = data.aws_route53_zone.public.id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name = tolist(aws_acm_certificate.ssl_certificate.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.ssl_certificate.domain_validation_options)[0].resource_record_type
  records = [
    tolist(aws_acm_certificate.ssl_certificate.domain_validation_options)[0].resource_record_value
  ]
  ttl = 300

  zone_id = data.aws_route53_zone.public.id
}