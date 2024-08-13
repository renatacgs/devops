variable "vpc_id" {
  description = "ID da VPC"
}

variable "public_subnet_id" {
  description = "ID da Subnet Pública"
}

variable "ec2_security_group_id" {
  description = "ID do Security Group para EC2"
}

variable "db_credentials_secret_name" {
  description = "Nome do segredo no AWS Secrets Manager para as credenciais do banco de dados"
}

variable "app_secret_name" {
  description = "Nome do segredo no AWS Secrets Manager para a aplicação"
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t2.micro"
}

variable "allocated_storage" {
  description = "Espaço alocado para o banco de dados RDS (em GB)"
  default     = 20
}

variable "engine" {
  description = "Engine do banco de dados RDS"
  default     = "mysql"
}

variable "engine_version" {
  description = "Versão da engine do RDS"
  default     = "8.0"
}

variable "instance_class" {
  description = "Classe da instância do RDS"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nome do banco de dados RDS"
}

variable "db_subnet_group_name" {
  description = "Nome do grupo de subnets para o RDS"
}
