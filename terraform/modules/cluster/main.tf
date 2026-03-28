# 1. The ECS Cluster itself
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

# 2. The Capacity Provider (KEEP ONLY ONE OF THESE)
resource "aws_ecs_capacity_provider" "main" {
  name = "${var.cluster_name}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.asg_arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
  }
}

# 3. Attach the Capacity Provider to the Cluster
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.main.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.main.name
  }
}