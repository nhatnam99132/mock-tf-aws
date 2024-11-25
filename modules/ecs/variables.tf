variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "my-ecs-cluster"
}

variable "region" {
  description = "The AWS region to deploy the ECS cluster"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID where the ECS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs where the ECS cluster will be deployed"
  type        = list(string)
}

variable "container_image" {
  description = "The Docker image for the ECS task"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 8080
}

variable "db_url" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "db_username" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "db_password" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "username" {
  description = "The desired number of ECS tasks"
  type        = string
}


variable "password" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "ecs_sg" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "desired_count" {
  description = "The desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "ecs_task_execution_role_arn" {
  description = "The desired number of ECS tasks"
  type        = string
}

variable "env" {
  type        = string
  description = "Name to be used on tag"
  default     = "DEV"
}

variable "ecs_tg_arn" {
  type        = string
}