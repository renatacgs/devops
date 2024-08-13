resource "aws_instance" "wordpress" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.wp_sg.id]

  tags = {
    Name = "WordPress"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo apt-get install -y mysql-client",
      "sudo apt-get install -y php libapache2-mod-php php-mysql",
      "curl -O https://wordpress.org/latest.tar.gz",
      "tar xzvf latest.tar.gz",
      "sudo cp -a wordpress/. /var/www/html/",
      "sudo chown -R www-data:www-data /var/www/html/",
      "sudo systemctl restart apache2"
    ]
  }
}
