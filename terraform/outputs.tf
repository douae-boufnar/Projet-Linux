output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.projet_linux_server.id
}



output "public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.projet_linux_server.public_ip
}

output "ssh_command" {
  description = "Commande SSH pour se connecter au serveur"
  value       = "ssh -i ~/.ssh/terraform-ec2.pem ubuntu@${aws_instance.projet_linux_server.public_ip}"
}

output "app_url" {
  description = "URL publique de l'application (Nginx Reverse Proxy)"
  value       = "http://${aws_instance.projet_linux_server.public_ip}"
}
