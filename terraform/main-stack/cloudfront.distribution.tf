resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = aws_s3_bucket.this.bucket_regional_domain_name
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["labs-devops-na-nuvem.tecnologia-i.com.br"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.this.bucket_regional_domain_name

    #Managed-CachingOptimized
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    viewer_protocol_policy = "allow-all"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.this.arn
    ssl_support_method  = "sni-only"
  }
}
 