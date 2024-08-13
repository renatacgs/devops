# Cria um bucket S3 para artefatos do pipeline
resource "aws_s3_bucket" "cicd_bucket" {
  bucket = var.bucket_name
  //acl    = "private"

  tags = {
    Name = "cicd-bucket"
  }
}
