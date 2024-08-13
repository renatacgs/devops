variable "region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "ec2_instance_type" {
  description = "Tipo de instância EC2 para Auto Scaling"
  type        = string
  default     = "t3.medium"
}
