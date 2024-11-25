variable "env" {
  description = "The environment name"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs where the ECS cluster will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the ECS cluster will be deployed"
  type        = string
}

variable "ecs_sg" {
  description = "The security group ID for the ECS service"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 8080
}

variable "ecs_instance_id" {
  description = "The port on which the container listens"
  type        = list(string)
}