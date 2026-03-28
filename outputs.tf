### 1. Networking Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

### 2. Access Points (The Most Important Ones!)
output "alb_dns_name" {
  description = "The URL of the Load Balancer to access the apps"
  value       = module.loadbalancer.alb_dns_name
}

output "frontend_url" {
  description = "Access the Frontend at this URL"
  value       = "http://${module.loadbalancer.alb_dns_name}"
}

output "backend_url" {
  description = "Access the Backend API at this URL"
  value       = "http://${module.loadbalancer.alb_dns_name}:8080"
}

### 3. Database Info
output "database_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.database.db_instance_endpoint
}

### 4. Compute Status
output "ecs_cluster_name" {
  description = "The name of the ECS Cluster"
  value       = module.cluster.cluster_name
}

output "asg_name" {
  description = "The name of the Auto Scaling Group managing your EC2s"
  value       = module.autoscaling.asg_name
}