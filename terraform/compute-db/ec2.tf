resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Escolha uma AMI compatível
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Web-Server"
  }
}
