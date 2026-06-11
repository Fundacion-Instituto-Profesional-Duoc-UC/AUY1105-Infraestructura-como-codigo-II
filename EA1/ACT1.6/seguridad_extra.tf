# 1. Obtener la identidad de la cuenta para no usar asteriscos en KMS
data "aws_caller_identity" "current" {}

# --- CORRECCIÓN CKV2_AWS_41: IAM Role para EC2 ---
resource "aws_iam_role" "ec2_role" {
  name = "role-ec2-log-access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# --- CORRECCIÓN CKV_AWS_158 y CKV_AWS_33 (KMS sin wildcards) ---
resource "aws_kms_key" "log_key" {
  description             = "Llave para cifrar logs de CloudWatch"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          # CKV_AWS_33 SOLUCIONADO: Se especifica la cuenta raíz en lugar de "*"
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "logs.us-east-1.amazonaws.com"
        }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

# --- CORRECCIÓN CKV2_AWS_11, CKV_AWS_338, CKV_AWS_66 ---
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name              = "vpc-flow-logs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.log_key.arn
}

resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc-flow-log-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
    }]
  })
}

resource "aws_flow_log" "mi_vpc_flow_log" {
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.mi_vpc.id
}

# --- CORRECCIÓN CKV2_AWS_12: Restringir Default Security Group ---
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mi_vpc.id
}