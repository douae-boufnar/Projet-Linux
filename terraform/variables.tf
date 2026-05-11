variable "aws_region" {
  default = "eu-west-3"
}

variable "instance_type" {
  description = "Type d'instance EC2 (Free Tier)"
  default     = "t3.micro"
}

variable "aws_ami_id" {
  description="c'est l'id de notre image ubunto"
  default="ami-0be40a46b4111e7f5"
}

variable "key_name" {
  description = "Nom de la Key Pair SSH"
  default     = "projet-linux-key"
}
variable "project_name" {
  description = "Nom du projet"
  default     = "projet-linux"
}

variable "github_repo_url" {
  description = "URL du dépôt GitHub du projet"
  default     = "https://github.com/douae-boufnar/Projet-Linux"
}
