resource "aws_route53_zone" "private" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name = "${var.project_name}-private-zone"
  }
}

resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "db01.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [var.rds_endpoint]
}

resource "aws_route53_record" "cache" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "mc01.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [var.cache_endpoint]
}

resource "aws_route53_record" "mq" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "rmq01.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [var.mq_endpoint]
}
