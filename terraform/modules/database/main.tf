resource "aws_db_subnet_group" "db_group" {
  name       = "main-db-subnet-group"
  subnet_ids = var.private_subnet_ids # Change from var.private_subnets
}

resource "aws_db_instance" "postgres" {
  identifier        = "app-db"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.db_group.name
  username          = var.db_user
  password          = var.db_password
  skip_final_snapshot = true
}