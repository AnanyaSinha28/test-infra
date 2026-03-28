# 1. Network Configuration
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# 2. Database Credentials (Required for the Database Module)
variable "db_user" {
  description = "Database administrator username"
  type        = string
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

# 3. Compute Configuration (Required for the Autoscaling Module)
variable "ecs_ami_id" {
  description = "The Amazon ECS-optimized AMI ID for your region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the ECS nodes"
  type        = string
  default     = "t3.micro"
}