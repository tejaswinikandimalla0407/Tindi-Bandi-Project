resource "aws_security_group" "sonar_sg" {
  name        = "sonar-sg"
  description = "Allow SSH and sonar UI"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "sonar" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sonar_sg.id]
  tags = {
    Name = "Sonar-Server"
  }
}
 