## Provider
# See @link:https://registry.terraform.io/providers/hashicorp/aws/latest/docs

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

## Resources
# See @link:https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance 

resource "aws_instance" "mongo_instance" {
  ami           = var.mongo_ami
  instance_type = "t2.micro"
  key_name      = var.key_pair

  tags = {
    Name = "mongo"
  }
}

resource "aws_instance" "server_instance" {
  ami           = var.server_ami
  instance_type = "t2.micro"
  key_name      = var.key_pair

  tags = {
    Name = "server"
  }

  depends_on = [aws_instance.mongo_instance]

  user_data = <<-EOF
              #!/bin/bash
              echo "mongodb://${aws_instance.mongo_instance.private_ip}:27017/test" > /mongo.env
              EOF
}

## Security Groups
# See @link:https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "deployment_sg" {
  name        = "mudevops05-deployment-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

## Network interfaces binds to security group and EC2 instances
# See @link:https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment

resource "aws_network_interface_sg_attachment" "mongo_instance_sg_attachment" {
  security_group_id    = aws_security_group.deployment_sg.id
  network_interface_id = aws_instance.mongo_instance.primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "server_instance_sg_attachment" {
  security_group_id    = aws_security_group.deployment_sg.id
  network_interface_id = aws_instance.server_instance.primary_network_interface_id
}
