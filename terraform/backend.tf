# Configuration du backend Terraform (état distant)
#
# L'état est maintenant stocké sur AWS S3 pour permettre 
# le travail collaboratif et éviter de recréer l'infrastructure.
#
terraform {
  backend "s3" {
    bucket         = "douae-projet-linux-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}
