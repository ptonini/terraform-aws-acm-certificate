output "this" {
  value = aws_acm_certificate.this
}

output "domain_validation_options" {
  value = local.domain_validation_options
}