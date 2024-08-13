provider "aws" {
  region = "sa-east-1" 
}

# Cria o Secrets Manager Secret para o banco de dados
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials"

  tags = {
    Name = "db-credentials"
  }
}

# Cria a versão do segredo com as credenciais do banco de dados
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}

# Cria o Secrets Manager Secret para a aplicação
resource "aws_secretsmanager_secret" "app_secret" {
  name = "app-secret"

  tags = {
    Name = "app-secret"
  }
}

# Cria a versão do segredo para a aplicação
resource "aws_secretsmanager_secret_version" "app_secret_version" {
  secret_id     = aws_secretsmanager_secret.app_secret.id
  secret_string = jsonencode({
    api_key = var.app_api_key
  })
}
