module "vpc" {
    source = "./modules/vpc"
    vpc_name          = var.vpc_name
    vpc_cidr_block    = var.vpc_cidr_block
    public_subnets    = var.public_subnets
    availability_zone = var.availability_zone
    env = var.env
}

# module "s3" {
#     source = "./modules/s3"
#     name = var.s3_name
#     env = var.env
# }

module "rds" {
    source = "./modules/rds"
    region = var.region
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    db_instance_class = var.db_instance_class
    subnet_list = module.vpc.public_subnets
    rds_sg_id = module.vpc.rds_sg_id
    env = var.env
    # depends_on = [ module.vpc ]
}

module "iam" {
  source = "./modules/iam"
  env = var.env
}

# module "elastic_beanstalk" {
#     source = "./modules/elastic-beanstalk"
#     region = var.region
#     application_name = var.application_name
#     environment_name = var.environment_name
#     s3_bucket = var.s3_name
#     s3_key = module.s3.s3_key
#     s3_object_id = module.s3.s3_object_id
#     rds_address = module.rds.db_instance_endpoint
#     rds_port = var.rds_port
#     db_name = var.db_name
#     db_username = var.db_username
#     db_password = var.db_password
#     vpc_id = module.vpc.vpc_id
#     subnet = module.vpc.public_subnets
#     env = var.env
#     depends_on = [ module.rds ]
# }
module "alb" {
    source = "./modules/load-balancer"
    container_port = var.container_port
    ecs_sg = module.vpc.api_sg_id
    subnet_ids = module.vpc.public_subnets
    vpc_id = module.vpc.vpc_id
    env = var.env
    ecs_instance_id  = module.ec2.ecs_instance_id
}

module "ecs" {
    source = "./modules/ecs"
    region = var.region
    cluster_name = var.cluster_name
    container_image = var.container_image
    container_port = var.container_port
    subnet_ids = module.vpc.public_subnets
    vpc_id = module.vpc.vpc_id
    db_password = var.db_password
    db_username = var.db_username
    db_url = "jdbc:mysql://${module.rds.db_instance_endpoint}/${var.db_name}"
    ecs_sg = module.vpc.alb_sg_id
    ecs_task_execution_role_arn = module.iam.execution_role_arn
    env = var.env
    ecs_tg_arn = module.alb.ecs_tg_arn
    desired_count = var.desired_count
    password = var.password
    username = var.username
}

module "ec2" {
    source = "./modules/ec2"
    cluster_name = var.cluster_name
    subnet_id = module.vpc.public_subnets[0]
    ecs_sg = module.vpc.alb_sg_id
    iam_instance_profile = module.iam.instance_profile_name
}