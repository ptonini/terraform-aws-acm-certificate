variable "domain_name" {}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "zone_id" {
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}