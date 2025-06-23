provider "aws"{
    region =var.region_name
}
 
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name 
    tags = {
        Name        = "Archika S3 Bucket"
        Environment = "Development"
    }
}



resource "aws_s3_bucket_website_configuration" "my_bucket_config" {
    bucket = aws_s3_bucket.my_bucket.id
    index_document {
        suffix = "index.html"
    }   
    error_document {
        key = "error.html"
    }    
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
    bucket = aws_s3_bucket.my_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource  "aws_s3_bucket_public_access_block" "my_bucket_pa_block" {
    bucket = aws_s3_bucket.my_bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
    bucket = aws_s3_bucket.my_bucket.id
    depends_on = [ aws_s3_bucket_public_access_block.my_bucket_pa_block ]
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.my_bucket.arn}/*"
            }
        ]
    })
}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.my_bucket.id
    key    = "index.html"
    source = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "error" {
    bucket = aws_s3_bucket.my_bucket.id
    key    = "error.html"
    source = "error.html"
    content_type = "text/html"
}
output "website_endpoint" {
    description = "The website endpoint of the S3 bucket"
    value = aws_s3_bucket_website_configuration.my_bucket_config.website_endpoint
}

output "website_url" {
    description = "The URL of the S3 bucket website"
    value = "http://${aws_s3_bucket.my_bucket.id}.s3-website.${var.region_name}.amazonaws.com"
}

output "bucket_arn" {
    value = aws_s3_bucket.my_bucket.arn
  
}