resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = var.common_tags
}

resource "aws_route53_record" "root-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "protonmail_dkim_1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "tdejao6sf75c3criwhuqvz6ac3ory2ms._domainkey.manrodri.com"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "tdejao6sf75c3criwhuqvz6ac3ory2ms.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "protonmail_dkim_2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "g4lrz3ur3genwlusrcxiczbzkcvmqfhp._domainkey.manrodri.com"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "g4lrz3ur3genwlusrcxiczbzkcvmqfhp.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "protonmail_dkim_3" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "qwax6w42d7si5rnvrfazteoxgsv3hnmt._domainkey.manrodri.com"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "qwax6w42d7si5rnvrfazteoxgsv3hnmt.dkim.amazonses.com"
  ]
}



resource "aws_route53_record" "certificate_validation" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_eacceef1fd45bc8dbf80daea65fb2666.manrodri.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["_ed4be52c0c77352c8bbb193d8caedefe.snmnbsbtgy.acm-validations.aws"]
}



