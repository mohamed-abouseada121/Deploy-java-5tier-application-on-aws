output "elb_sg_id" {
  value = aws_security_group.elb_sg.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
}
