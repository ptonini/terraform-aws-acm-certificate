variable "domain_name" {}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "route53_zone" {
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}