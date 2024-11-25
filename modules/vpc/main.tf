resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name"            = var.vpc_name
    "Environment" = var.env
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zone[count.index % length(var.availability_zone)]
  map_public_ip_on_launch = true

  tags = {
    "Name"            = var.vpc_name
    "Environment" = var.env
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name"            = var.vpc_name
    "Environment" = var.env
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    "Name"            = var.vpc_name
    "Environment" = var.env
  }
}

resource "aws_route_table_association" "public_association" {
  for_each       = { for k, v in aws_subnet.public_subnets : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds_sg"
  description = "Allow inbound traffic to RDS"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups   = [aws_security_group.lb_allow_all_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "api_ec2_sg" {
  name        = "${var.env}-api-ec2-sg"
  description = "Allow api EC2 server inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"            = var.vpc_name
    "Environment" = var.env
  }
}

resource "aws_security_group" "lb_allow_all_sg" {
  name        = "${var.env}-lb-allow-all-sg"
  description = "Allow all traffic to Load Balancer Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description       = "Allow all traffic to LB SG"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    security_groups   = [aws_security_group.api_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"        = "Allow-All-to-LB-SG"
    "Environment" = var.env
  }
}
