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
  profile = "reda_dev"
}



# Instance EC2
resource "aws_instance" "projet_linux_server" {
  ami                    = var.aws_ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address=true
  vpc_security_group_ids = [aws_security_group.projet_linux_sg.id]
  user_data_replace_on_change = true

  # Stockage 20 GB gp2 (Free Tier)
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  # Script d'installation automatique via Snap (Idéal pour Ubuntu très récent)
  user_data = <<-EOF
    #!/bin/bash
    # 1. Mise à jour
    apt-get update -y
    apt-get install -y git

    # 2. Ajout de la mémoire SWAP (2Go) pour éviter le crash OOM (Exit 137) d'Angular
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab

    # 3. Installation de Docker via Snap
    snap install docker
    
    # On attend que Snap finisse de bien configurer Docker
    sleep 10

    # 4. Récupération du code
    cd /home/ubuntu
    git clone -b reda-dev ${var.github_repo_url} projet
    cd projet

    # 5. Lancement de l'application
    sudo docker compose up -d

    # Fix permissions
    chown -R ubuntu:ubuntu /home/ubuntu/projet
  EOF

  tags = {
    Name = "${var.project_name}-server"
  }
}


