output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "iam_execution_role_arn" {
  value = module.iam.execution_role_arn
}

output "alb_endpoint" {
  value = module.alb.load_balancer_dns
}
