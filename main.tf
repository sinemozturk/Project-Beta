
#Provider Block for Terraform + AWS

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# S3 bucket for website.

resource "aws_s3_bucket" "main-bucket" {
    bucket = "www.${var.bucket_name}"
    acl = "public-read"
    policy = file("policy.json")

    versioning {
      enabled = true
    }
    
    cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
    }
    
    website {
      index_document = "index.html"
      error_document = "error.html"
    }

    tags = {
        name = var.common_tags
    }
}

resource "aws_s3_bucket_website_configuration" "name" {
    bucket = "www.${var.bucket_name}"
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "error.html"
    }  
  
}


resource "aws_s3_bucket_object" "objects" {
    for_each = fileset("files/", "*")
    bucket = "www.${var.bucket_name}"
    key = each.value
    source = "files/${each.value}"
    etag = filemd5("files/${each.value}")
}



# # Create A record for re-directing the traffics to your-s3-bucket

# resource "aws_route53_record" "exampleDomain-a" {
#   zone_id = aws_route53_zone.exampleDomain.zone_id
#   name    = var.domainName
#   type    = "A"
#   alias {
#     name                   = aws_s3_bucket.example.website_endpoint
#     zone_id                = aws_s3_bucket.example.hosted_zone_id
#     evaluate_target_health = true
#   }
# }










