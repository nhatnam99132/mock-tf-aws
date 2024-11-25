variable "vpc_name" {
  type        = string
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = []
}

variable "api_ec2_sg" {
  type        = string
  description = "Name to be used on api security group"
  default     = ""
}

variable "env" {
  type        = string
  description = "Name to be used on tag"
  default     = "DEV"
}

variable "s3_name" {
  type        = string
  description = "Name to be used for S3 bucket"
}

variable "region" {
  description = "AWS region to deploy the RDS instance"
  default     = "us-east-1"
}

variable "db_name" {
  description = "The name of the database"
  default     = "mydatabase"
}

variable "db_username" {
  description = "The master username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the database"
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  default     = "db.t4g.micro"
}

variable "application_name" {
  description = "Elastic Beanstalk application name"
  default     = "my-tomcat-app"
}

variable "environment_name" {
  description = "Elastic Beanstalk environment name"
  default     = "my-tomcat-env"
}

# variable "s3_key" {
#   description = "S3 key for the artifact"
# }

variable "rds_port" {
  description = "RDS port"
}

variable "role_arn" {
  type = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "my-ecs-cluster"
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

variable "desired_count" {
  description = "The desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "username" {
  description = "The desired number of ECS tasks"
  type        = string
}


variable "password" {
  description = "The desired number of ECS tasks"
  type        = string
}
