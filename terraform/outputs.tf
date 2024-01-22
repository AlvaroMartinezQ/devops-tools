output "mongo_ip" {
  value = aws_instance.mongo_instance.private_ip
}

output "node_ip" {
  value = aws_instance.server_instance.private_ip
}
