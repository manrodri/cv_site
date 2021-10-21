##################################################################################
# RESOURCES
##################################################################################

# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket        = "www.${local.bucket_name}"
  acl           = "public-read"
  policy        = templatefile("policy.json", { bucket = "www.${local.bucket_name}" })
  force_destroy = true

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${local.domain_name}"]
    max_age_seconds = 3000
  }

  versioning {
    enabled = true
  }


  website {
    index_document = "index.html"
    error_document = "error.html"


  }

  tags = var.common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket        = local.bucket_name
  acl           = "public-read"
  policy        = templatefile("policy.json", { bucket = local.bucket_name })
  force_destroy = true

  website {
    redirect_all_requests_to = "https://www.${local.domain_name}"
  }

  tags = var.common_tags
}
