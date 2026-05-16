resource "aws_security_group" "projet_linux_sg" {
  name        = "${var.project_name}-sg"
  description = "Security Group pour Projet Linux (Reverse Proxy Nginx)"

  # SSH - accès admin
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["41.249.66.215/32"]
  }

  # HTTP - Trafic Web Principal (Nginx Reverse Proxy)
  ingress {
    description = "HTTP (Nginx Reverse Proxy)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tout le trafic sortant autorisé
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}
