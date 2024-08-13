output "wordpress_instance_id" {
  description = "ID da instância EC2 do WordPress"
  value       = aws_instance.wordpress.id
}

output "wordpress_instance_public_ip" {
  description = "Endereço IP público da instância EC2 do WordPress"
  value       = aws_instance.wordpress.public_ip
}

output "wordpress_db_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = aws_db_instance.wordpress_db.endpoint
}

output "wordpress_db_name" {
  description = "Nome do banco de dados RDS"
  value       = aws_db_instance.wordpress_db.name
}
