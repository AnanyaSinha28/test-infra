# --- Network Configuration ---
vpc_cidr       = "10.0.0.0/16"

# --- Database Configuration ---
db_user       = "dbadmin"
db_password   = "StrongPassword2026!" # Change this!

# --- Compute / EC2 Configuration ---
# This is the Amazon Linux 2023 ECS-Optimized AMI for us-east-1
ecs_ami_id    = "ami-053ef1196395368a5" 
instance_type = "t3.micro"

# --- Application Configuration ---
frontend_image = "nginx:latest"
backend_image  = "amazon/amazon-ecs-sample
