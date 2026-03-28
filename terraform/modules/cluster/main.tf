resource "aws_ecs_cluster" "main" {
  name = "test-app-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name
  capacity_providers = ["EC2"]
}