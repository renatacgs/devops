# Network ACL para a Subnet Pública
resource "aws_network_acl" "public_nacl" {
  vpc_id = data.aws_vpc.main.id
  subnet_ids = [data.aws_subnet.public_subnet_1.id]

  # Permite tráfego HTTP e HTTPS de entrada
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    rule_no    = 110
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Permite tráfego SSH de entrada
  ingress {
    rule_no    = 120
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # Permite todo o tráfego de saída
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "public-nacl"
  }
}

# Network ACL para a Subnet Privada
resource "aws_network_acl" "private_nacl" {
  vpc_id = data.aws_vpc.main.id
  subnet_ids = [data.aws_subnet.private_subnet_1.id]

# Permite tráfego de entrada do MySQL
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = data.aws_subnet.private_subnet_1.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

# Permitie todo o tráfego de saída
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "private-nacl"
  }
}
