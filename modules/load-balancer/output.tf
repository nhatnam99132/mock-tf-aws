output "ecs_tg_arn" {
    value = aws_lb_target_group.ecs_tg.arn
  
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.ecs_lb.dns_name
}
