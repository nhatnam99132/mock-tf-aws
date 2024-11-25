
resource "aws_iam_role_policy" "ecs_task_execution_role_custom_policy" { 
    name = "${var.env}-ecsTaskExecutionRoleCustomPolicy"
    role = aws_iam_role.ecs_task_execution_role.id
    policy = jsonencode({
         Version = "2012-10-17", Statement = [ { 
            Effect = "Allow",
            Action = [ "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents" ],
            Resource = "*" 
        } ] }) 
    }

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.env}-ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.env}-AmazonEC2ContainerServiceforEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy_ec2" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.env}-ecsInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}
