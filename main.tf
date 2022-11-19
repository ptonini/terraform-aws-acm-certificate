resource "aws_acm_certificate" "this" {
  provider = aws.current
  domain_name  = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

module "dns_record" {
  source = "github.com/ptonini/terraform-aws-route53-record?ref=v1"
  for_each = { for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name =>
  {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }
  route53_zone = var.route53_zone
  name = each.value["name"]
  type = each.value["type"]
  records = [
    each.value["record"]
  ]
  providers = {
    aws = aws.dns
  }
}