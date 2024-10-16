resource "aws_ecs_cluster" "one2ntask" {
  name = var.cluster_name
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecsExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

resource "aws_iam_role_policy" "ecs_execution_policy" {
  name   = "ECSExecutionPolicy"
  role   = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]  # Correct service for ECS tasks
    }
  }
}

resource "aws_ecs_task_definition" "one2ntask" {
  family                   = "one2ntask-family"
  execution_role_arn      = aws_iam_role.ecs_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_role.arn
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512

  container_definitions = jsonencode([
    {
      name      = "one2ntask"
      image     = var.one2ntaskimage
      
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
            name    = "AWS_ACCESS_KEY_ID"
            value   = var.AWS_ACCESS_KEY_ID
        },
        {
            name    = "AWS_SECRET_ACCESS_KEY"
            value   = var.AWS_SECRET_ACCESS_KEY
        },
        {
            name    = "AWS_S3_BUCKET_NAME"
            value   = var.AWS_S3_BUCKET_NAME
        },
        {
            name    = "AWS_REGION"
            value   = var.AWS_REGION
        } 
      ]
    }
  ])
}

resource "aws_security_group" "one2ntask_security_group" {
  name   = "one2ntask-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port              = 8000       # Allow traffic on the port where the container listens
    to_port                = 8000
    protocol               = "tcp"
    description            = "Allow ingress on port 8000"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an ECS service that uses the task definition.
resource "aws_ecs_service" "one2ntask_service" {
  name            = "one2ntask-service"

  cluster         = aws_ecs_cluster.one2ntask.id 
  task_definition = aws_ecs_task_definition.one2ntask.id 

  desired_count   = 1 

  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.public_subnet_id]  # Use the public subnet for public access
    security_groups  = [aws_security_group.one2ntask_security_group.id]  
    assign_public_ip = true                     # Enable public IP assignment
  }
}