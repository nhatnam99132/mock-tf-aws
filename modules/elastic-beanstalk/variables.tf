variable "region" {
  description = "AWS region to deploy the application"
  default     = "us-east-1"
}

variable "application_name" {
  description = "Elastic Beanstalk application name"
  default     = "my-tomcat-app"
}

variable "environment_name" {
  description = "Elastic Beanstalk environment name"
  default     = "my-tomcat-env"
}

variable "s3_bucket" {
  description = "S3 bucket containing the artifact"
}

variable "s3_key" {
  description = "S3 key for the artifact"
}

variable "s3_object_id" {
  
}

variable "rds_address" {
  description = "Hostname of RDS"
}

variable "rds_port" {
  description = "RDS port"
}

variable "db_name" {
  description = "DB Name"
}

variable "db_username" {
  description = "DB username"
}

variable "db_password" {
  description = "DB password"
}

variable "vpc_id" {
  description = "DB username"
}

variable "subnet" {
  description = "DB password"
}

variable "env" {
  type        = string
  description = "Name to be used on tag"
  default     = "DEV"
}