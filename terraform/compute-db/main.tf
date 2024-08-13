provider "aws" {
  region = "sa-east-1" 
}

# Importa a VPC, Subnets e Security Groups
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet_1" {
  id = var.public_subnet_id
}

data "aws_subnet" "private_subnet_1" {
  id = var.private_subnet_id
}

data "aws_security_group" "ec2_sg" {
  id = var.ec2_security_group_id
}

data "aws_security_group" "rds_sg" {
  id = var.rds_security_group_id
}

# Cria uma instância EC2 na Subnet Pública
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.public_subnet_1.id
  security_groups = [data.aws_security_group.ec2_sg.name]

  tags = {
    Name = "web-server"
  }
}

# Cria um banco de dados RDS na Subnet Privada
resource "aws_db_instance" "app_db" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.app_db_subnet_group.name
  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "app-db"
  }
}

# Cria um Subnet Group para o RDS
resource "aws_db_subnet_group" "app_db_subnet_group" {
  name       = "app-db-subnet-group"
  subnet_ids = [data.aws_subnet.private_subnet_1.id]

  tags = {
    Name = "app-db-subnet-group"
  }
}
