resource "aws_mq_broker" "main" {
  broker_name                = "${var.project_name}-mq"
  engine_type                = "RabbitMQ"
  engine_version             = "3.13"
  auto_minor_version_upgrade = true
  host_instance_type         = "mq.t3.micro"
  security_groups            = [var.backend_sg_id]
  subnet_ids                 = [var.private_subnets[0]] # Single instance broker needs one subnet

  user {
    username = var.mq_username
    password = var.mq_password
  }

  tags = {
    Name = "${var.project_name}-mq"
  }
}
