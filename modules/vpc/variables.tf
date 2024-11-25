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

# variable "private_subnets" {
#   description = "A list of private subnets inside the VPC"
#   type        = list(string)
#   default     = []
# }

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