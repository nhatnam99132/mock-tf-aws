output "public_subnets" {
  value = [for k, v in aws_subnet.public_subnets : v.id]
}

output "api_sg_id" {
  value = aws_security_group.api_ec2_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.lb_allow_all_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}