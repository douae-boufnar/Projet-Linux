# Configuration du backend Terraform (état distant)
#
# Par défaut le state est stocké LOCALEMENT.
# Pour une démo de cours, laisser ce fichier tel quel (backend local) est acceptable.
#
# OPTION A – Backend S3 (recommandé pour la prod)
# terraform {
#   backend "s3" {
#     bucket         = "projet-linux-terraform-state"
#     key            = "prod/terraform.tfstate"
#     region         = "eu-west-3"
#     encrypt        = true
#   }
# }
