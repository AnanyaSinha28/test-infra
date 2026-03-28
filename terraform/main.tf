# 1. Network
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

# 2. Security & Permissions
module "roles" {
  source = "./modules/roles"
}

# 3. Database
module "database" {
  source             = "./modules/database"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_user            = var.db_user
  db_password        = var.db_password
}

# 4. Load Balancer
module "loadbalancer" {
  source            = "./modules/loadbalancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.vpc.alb_sg_id 
}

# 5. EC2 Fleet (The Hosts)
module "autoscaling" {
  source                = "./modules/autoscaling"
  cluster_name          = "test-app-cluster"
  ami_id                = var.ecs_ami_id
  instance_type         = "t3.micro"
  instance_profile_name = module.roles.instance_profile_name
  node_sg_id            = module.vpc.node_sg_id # Ensure this is in VPC outputs
  private_subnet_ids    = module.vpc.private_subnet_ids
}

# 6. ECS Cluster
module "cluster" {
  source       = "./modules/cluster"
  cluster_name = "test-app-cluster"
  asg_arn      = module.autoscaling.asg_arn
}

# 7. Frontend Service
module "frontend_service" {
  source                 = "./modules/services"
  service_name           = "frontend"
  cluster_id             = module.cluster.cluster_id
  execution_role_arn     = module.roles.execution_role_arn
  container_image        = "nginx:latest" # Replace with your ECR image later
  container_port         = 80
  private_subnet_ids     = module.vpc.private_subnet_ids
  target_group_arn       = module.loadbalancer.frontend_tg_arn
  capacity_provider_name = module.cluster.capacity_provider_name
  service_sg_id          = module.vpc.node_sg_id
}

# 8. Backend Service
module "backend_service" {
  source                 = "./modules/services"
  service_name           = "backend"
  cluster_id             = module.cluster.cluster_id
  execution_role_arn     = module.roles.execution_role_arn
  container_image        = "my-backend-app:latest"
  container_port         = 8080
  private_subnet_ids     = module.vpc.private_subnet_ids
  target_group_arn       = module.loadbalancer.backend_tg_arn
  capacity_provider_name = module.cluster.capacity_provider_name
  service_sg_id          = module.vpc.node_sg_id
}