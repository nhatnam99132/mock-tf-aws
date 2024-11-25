# resource "aws_elastic_beanstalk_application" "app" {
#   name        = var.application_name
#   description = "Elastic Beanstalk Application for Tomcat 10 with Java 17"
# }

# resource "aws_elastic_beanstalk_application_version" "example" {
#   name = "tomcat-example-version"
#   application = aws_elastic_beanstalk_application.app.name
#   bucket = var.s3_bucket
#   key = var.s3_object_id
# }

# resource "aws_elastic_beanstalk_environment" "tomcat" {
#   name                = var.environment_name
#   application         = aws_elastic_beanstalk_application.app.name
#   solution_stack_name = "64bit Amazon Linux 2023 v5.4.1 running Tomcat 10 Corretto 17"
#   version_label       = aws_elastic_beanstalk_application_version.example.name

#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "EnvironmentType"
#     value     = "SingleInstance"
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "VPCId"
#     value     = var.vpc_id
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "Subnets"
#     value     = var.subnet[0]
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "RDS_HOSTNAME"
#     value     = var.rds_address
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "RDS_PORT"
#     value     = var.rds_port
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "RDS_DB_NAME"
#     value     = var.db_name
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "RDS_USERNAME"
#     value     = var.db_username
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "RDS_PASSWORD"
#     value     = var.db_password
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "AssociatePublicIpAddress"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     =  aws_iam_instance_profile.beanstalk_instance_profile.name
#   }


#   tags = {
#     Name        = var.environment_name
#     Environment = var.env
#   }
# }


# resource "aws_iam_role" "elastic_beanstalk_role" {
#   name = "elastic_beanstalk_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "web_tier_policy" {
#   role       = aws_iam_role.elastic_beanstalk_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
# }

# resource "aws_iam_role_policy_attachment" "worker_tier_policy" {
#   role       = aws_iam_role.elastic_beanstalk_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
# }

# resource "aws_iam_role_policy_attachment" "multicontainer_docker_policy" {
#   role       = aws_iam_role.elastic_beanstalk_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
# }

# resource "aws_iam_instance_profile" "beanstalk_instance_profile" {
#   name = "elastic_beanstalk_role"
#   role = aws_iam_role.elastic_beanstalk_role.name
# }
