resource "aws_s3_bucket" "one2ntask" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "one2ntask" {
  bucket = aws_s3_bucket.one2ntask.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
