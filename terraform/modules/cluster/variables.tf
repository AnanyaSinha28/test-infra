variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "asg_arn" {
  description = "The ARN of the Auto Scaling Group to associate with the cluster"
  type        = string
}