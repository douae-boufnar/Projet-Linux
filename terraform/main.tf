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

  # Script d'installation automatique de Docker, Git et lancement du projet
  user_data = <<-EOF
    #!/bin/bash
    # 1. Mise à jour et installation des pré-requis
    apt-get update -y
    apt-get install -y ca-certificates curl gnupg lsb-release git

    # 2. Ajout de la clé GPG officielle de Docker
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # 3. Configuration du dépôt Docker
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 4. Installation de Docker et Docker Compose
    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # 5. Démarrage de Docker
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu

    # 6. Récupération du code
    cd /home/ubuntu
    git clone -b reda-dev ${var.github_repo_url} projet
    cd projet

    # 7. Lancement de l'application
    sleep 10
    sudo docker compose up -d --build

    # Fix permissions
    chown -R ubuntu:ubuntu /home/ubuntu/projet
  EOF

  tags = {
    Name = "${var.project_name}-server"
  }
}


