output "bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.cicd_bucket.bucket
}

output "role_arn" {
  description = "ARN da role IAM para GitHub Actions"
  value       = aws_iam_role.github_actions_role.arn
}
