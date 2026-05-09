terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Key Pair SSH
resource "aws_key_pair" "projet_linux_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/projet-linux-key.pub")
}

# Instance EC2
resource "aws_instance" "projet_linux_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.projet_linux_key.key_name
  vpc_security_group_ids = [aws_security_group.projet_linux_sg.id]

  # Stockage 20 GB gp2 (Free Tier)
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  # Script d'installation automatique de Docker au démarrage
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io git
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu
    apt-get install -y docker-compose-plugin
  EOF

  tags = {
    Name = "${var.project_name}-server"
  }
}

# IP publique fixe
resource "aws_eip" "projet_linux_eip" {
  instance = aws_instance.projet_linux_server.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}
