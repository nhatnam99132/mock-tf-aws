resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.39"
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  # Free Tier requires publicly accessible to be false
  publicly_accessible = false

  # Apply the Free Tier settings
  backup_retention_period = 0
  multi_az                = false

  # VPC and Subnet Group
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
  identifier =  var.db_name
  
  tags = {
    "Name"        =  var.db_name
    "Environment" = var.env
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.db_name}_rds_subnet_group"
  subnet_ids = var.subnet_list # Replace with your subnet IDs

  tags = {
    "Name"        =  var.db_name
    "Environment" = var.env
  }
}
