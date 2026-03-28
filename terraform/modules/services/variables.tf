variable "service_name" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "cpu" {
  type    = string
  default = "256"
}

variable "memory" {
  type    = string
  default = "512"
}

variable "execution_role_arn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "service_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "capacity_provider_name" {
  type        = string
  description = "The name of the capacity provider linked to the ASG"
}
variable "task_role_arn" {
  type    = string
  default = null # Optional if you don't have a specific task role yet
}