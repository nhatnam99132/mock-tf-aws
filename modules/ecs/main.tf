resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.env}-task-family"
  network_mode             = "awsvpc"
  # requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-my-container"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      environment = [
        {
            name = "DB_URL"
            value = var.db_url
        },
        { 
            name = "DB_USERNAME"
            value = var.db_username 
        },
        { 
            name = "DB_PASSWORD"
            value = var.db_password
        },
        { 
            name = "USER_NAME"
            value = var.username
        },
        { 
            name = "USER_PASSWORD"
            value = var.password
        },
      ]
      logConfiguration = { 
        logDriver = "awslogs"
        options = { 
            "awslogs-create-group" = "true"
            "awslogs-group" = "/ecs/my-task-family"
            "awslogs-region" = var.region
            "awslogs-stream-prefix" = "ecs"
        }
        }
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.env}-my-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  # launch_type     = "FARGATE"
  launch_type = "EC2"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.ecs_sg]
  }

  load_balancer { 
    target_group_arn = var.ecs_tg_arn
    container_name = "${var.env}-my-container"
    container_port = var.container_port
    }
}
