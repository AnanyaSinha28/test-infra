resource "aws_launch_template" "ecs_nodes" {
  name_prefix   = "ecs-node-"
  image_id      = var.ami_id # Must be an ECS-optimized AMI
  instance_type = var.instance_type

  # This User Data script links the EC2 instance to your specific ECS Cluster
  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
              EOF
  )

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.node_sg_id]
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.ecs_nodes.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
