provider "aws" {
  region = "sa-east-1" 
}

# Importando a VPC, Subnets, Security Groups e Secrets Manager
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet_1" {
  id = var.public_subnet_id
}

data "aws_security_group" "ec2_sg" {
  id = var.ec2_security_group_id
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = var.db_credentials_secret_name
}

data "aws_secretsmanager_secret" "app_secret" {
  name = var.app_secret_name
}

# Instância EC2 para hospedar o WordPress
resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.public_subnet_1.id
  security_groups = [data.aws_security_group.ec2_sg.name]
  
  tags = {
    Name = "wordpress-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y apache2 mysql-client php php-mysql
              systemctl start apache2
              systemctl enable apache2
              wget https://wordpress.org/latest.tar.gz
              tar xzvf latest.tar.gz
              cp -a wordpress/. /var/www/html/
              chown -R www-data:www-data /var/www/html/
              chmod -R 755 /var/www/html/
              EOF
}

# Configuração do banco de dados usando os secrets
resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.db_name
  username             = data.aws_secretsmanager_secret.db_credentials.secret_string["username"]
  password             = data.aws_secretsmanager_secret.db_credentials.secret_string["password"]
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "wordpress-db"
  }
}
