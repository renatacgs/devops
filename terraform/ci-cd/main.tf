provider "aws" {
  region = "sa-east-1"  
}

# Cria um bucket S3 para armazenar artefatos do pipeline
resource "aws_s3_bucket" "cicd_bucket" {
  bucket = var.bucket_name
  //acl    = "private"

  tags = {
    Name = "cicd-bucket"
  }
}

# Cria uma role IAM para o GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
