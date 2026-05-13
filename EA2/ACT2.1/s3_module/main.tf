resource "aws_s3_bucket" "mi_bucket" {
  bucket = "${var.bucket_prefix}-${var.bucket_suffix}"

  tags = merge({
    Name = "${var.bucket_prefix}-${var.bucket_suffix}"
  }, var.tags)
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mi_bucket.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mi_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "public_read" {
  count = var.enable_public_policy ? 1 : 0

  bucket = aws_s3_bucket.mi_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.mi_bucket.arn}/*"
      }
    ]
  })
}