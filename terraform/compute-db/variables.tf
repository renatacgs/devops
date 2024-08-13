# variables.tf

variable "vpc_id" {
  description = "ID da VPC"
}

variable "public_subnet_id" {
  description = "ID da Subnet Pública"
}

variable "private_subnet_id" {
  description = "ID da Subnet Privada"
}

variable "ec2_security_group_id" {
  description = "ID do Security Group para EC2"
}

variable "rds_security_group_id" {
  description = "ID do Security Group para RDS"
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t2.micro"
}

variable "allocated_storage" {
  description = "Espaço alocado para o RDS (em GB)"
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

variable "db_username" {
  description = "Usuário do banco de dados RDS"
}

variable "db_password" {
  description = "Senha do banco de dados RDS"
}
