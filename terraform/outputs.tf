output "ec2_public_ip" {
  value = module.ec2.instance_public_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "cache_endpoint" {
  value = module.elasticache.cache_endpoint
}

output "mq_endpoint" {
  value = module.mq.mq_endpoint
}
