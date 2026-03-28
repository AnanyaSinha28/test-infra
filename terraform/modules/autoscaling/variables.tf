variable "cluster_name"        { type = string }
variable "instance_type"       { type = string, default = "t3.micro" }
variable "instance_profile_name" { type = string }
variable "node_sg_id"          { type = string }
variable "private_subnet_ids"  { type = list(string) }
variable "desired_capacity"    { type = number, default = 2 }
variable "max_size"            { type = number, default = 4 }
variable "min_size"            { type = number, default = 1 }

# You can find the latest ECS AMI ID for your region in the AWS Console
variable "ami_id" { 
  type        = string
  description = "Amazon ECS-optimized AMI ID"
}