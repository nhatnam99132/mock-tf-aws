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

variable "subnet_list" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "env" {
  type        = string
  description = "Name to be used on tag"
  default     = "DEV"
}

variable "rds_sg_id" {
  type        = string  
}
