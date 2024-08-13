variable "bucket_name" {
  description = "Nome do bucket S3 para armazenar artefatos do pipeline"
  type        = string
}

variable "role_name" {
  description = "Nome da role IAM para GitHub Actions"
  type        = string
}
