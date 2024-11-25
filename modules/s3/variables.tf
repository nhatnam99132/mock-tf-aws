variable "name" {
  type        = string
  description = "Name to be used for S3 bucket"
}

variable "env" {
  type        = string
  description = "Name to be used on tag"
  default     = "DEV"
}