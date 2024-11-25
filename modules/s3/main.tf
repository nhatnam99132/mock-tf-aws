resource "aws_s3_bucket" "bucket" {
  bucket = var.name

  tags = {
    "Name"            = var.name
    "Environment" = var.env
  }
}

# resource "aws_s3_object" "object" {
#   bucket = aws_s3_bucket.bucket.bucket
#   key    = "dev-mock-project-api.war"
#   source = "E:/DevOps/mock-terraform/dev-mock-project-api.war"

#   # etag = filemd5("E:/DevOps/mock-terraform/dev-mock-project-api.war")
# }

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}