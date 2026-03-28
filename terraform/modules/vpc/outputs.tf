output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "nat_gateway_ip" {
  description = "The public IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}
output "node_sg_id" {
  description = "The security group ID for the ECS nodes"
  value       = aws_security_group.ecs_nodes.id 
}
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}