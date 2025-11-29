output "mq_endpoint" {
  # RabbitMQ usually exposes amqps endpoint
  value = aws_mq_broker.main.instances[0].endpoints[0]
}
