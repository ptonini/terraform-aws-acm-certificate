variable "domain_name" {}

variable "subject_alternative_names" {
  type = list(string)
  default = []
}

variable "route53_zone" {}