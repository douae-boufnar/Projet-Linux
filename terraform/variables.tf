variable "aws_region" {
  description = "Région AWS"
  default     = "eu-north-1"  # Stockholm
}

variable "instance_type" {
  description = "Type d'instance EC2 (Free Tier)"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS - eu-north-1 (Stockholm)"
  default     = "ami-0989fb15ce71ba39e"
}

variable "key_name" {
  description = "Nom de la Key Pair SSH"
  default     = "projet-linux-key"
}

variable "project_name" {
  description = "Nom du projet"
  default     = "projet-linux"
}
