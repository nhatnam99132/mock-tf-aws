variable "subnet_id" {
  description = "The subnet ID where the EC2 instances will be launched"
  type        = string
}

variable "ecs_sg" {
  description = "The security group ID for the ECS instances"
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "iam_instance_profile" {
  description = "The name of the ECS cluster"
  type        = string
}
