output "ecs_instance_id" {
  value = aws_instance.ecs_instance[*].private_ip
}
