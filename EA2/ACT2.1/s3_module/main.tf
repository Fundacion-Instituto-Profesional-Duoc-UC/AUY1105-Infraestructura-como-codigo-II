# 1. Creación del Bucket
resource "aws_s3_bucket" "mi_bucket" {
  bucket = "${var.bucket_prefix}-${var.bucket_suffix}"
  tags   = var.tags
}

# 2. Habilitar el Versionado (Requerimiento)
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mi_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Desactivar bloqueos de acceso público
# Esto permite que la política de "Solo Lectura" funcione
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mi_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 4. Política de acceso público (Solo Lectura)
resource "aws_s3_bucket_policy" "read_only_policy" {
  bucket = aws_s3_bucket.mi_bucket.id
  
  # IMPORTANTE: Espera a que se desbloquee el acceso público antes de aplicar la política
  depends_on = [aws_s3_bucket_public_access_block.public_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.mi_bucket.arn}/*"
      },
    ]
  })
}