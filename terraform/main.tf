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



# Instance EC2
resource "aws_instance" "projet_linux_server" {
  ami                    = var.aws_ami_id
  instance_type          = var.instance_type
  aws_key_pair = "terraform-ec2"
  associate_public_ip_address=true
  vpc_security_group_ids = [aws_security_group.projet_linux_sg.id]
  user_data_replace_on_change = true

  # Stockage 20 GB gp2 (Free Tier)
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  # Script d'installation automatique de Docker, Git et lancement du projet
  user_data = <<-EOF
    #!/bin/bash
    # 1. Mise à jour et installation des outils
    apt-get update -y
    apt-get install -y docker.io git
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu
    apt-get install -y docker-compose-plugin

    # 2. Récupération du code
    cd /home/ubuntu
    git clone ${var.github_repo_url} projet
    cd projet

    # 3. Lancement de l'application
    # On attend que Docker soit prêt
    sleep 10
    docker compose up -d --build

    # Fix permissions
    chown -R ubuntu:ubuntu /home/ubuntu/projet
  EOF

  tags = {
    Name = "${var.project_name}-server"
  }
}


