resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from your IP"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BastionSG"
  }
}

resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[0]
  key_name                    = var.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "BastionHost"
  }
}
 