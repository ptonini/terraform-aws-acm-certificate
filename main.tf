locals {
  domain_validation_options = { for o in aws_acm_certificate.this.domain_validation_options : o.domain_name => {
    name   = o.resource_record_name
    record = o.resource_record_value
    type   = o.resource_record_type
  } }
}

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["business_unit"],
      tags["product"],
      tags["env"],
      tags_all,

    ]
  }
}

module "dns_record" {
  source       = "ptonini/route53-record/aws"
  version      = "~> 1.1.1"
  for_each     = var.zone_id == null ? {} : local.domain_validation_options
  zone_id = var.zone_id
  name         = each.value["name"]
  type         = each.value["type"]
  records      = [each.value["record"]]
}