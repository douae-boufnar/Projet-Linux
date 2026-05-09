output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.projet_linux_server.id
}

output "public_ip" {
  description = "IP publique fixe du serveur"
  value       = aws_eip.projet_linux_eip.public_ip
}

output "ssh_command" {
  description = "Commande SSH pour se connecter au serveur"
  value       = "ssh -i ~/.ssh/projet-linux-key ubuntu@${aws_eip.projet_linux_eip.public_ip}"
}

output "frontend_url" {
  description = "URL du frontend Angular"
  value       = "http://${aws_eip.projet_linux_eip.public_ip}:4200"
}

output "backend_url" {
  description = "URL du backend Laravel"
  value       = "http://${aws_eip.projet_linux_eip.public_ip}:8000"
}
