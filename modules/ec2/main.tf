resource "aws_instance" "ecs_instance" {
  ami           = "ami-0f0362fe876878f3e"  # Replace with ECS-optimized AMI ID
  instance_type = "t2.micro"
  count         = 1
  subnet_id     = var.subnet_id
  security_groups = [var.ecs_sg]
    iam_instance_profile = var.iam_instance_profile

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
              yum install -y ecs-init
              service docker start
              start ecs
              EOF

  tags = {
    Name = "${var.cluster_name}ECS Instance"
  }
}
