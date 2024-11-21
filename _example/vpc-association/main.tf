provider "aws" {
  region = "us-east-1"
}

module "route53" {
  source = "../../"

  enabled         = true
  name            = "route53"
  environment     = "test"
  label_order     = ["environment", "name"]
  private_enabled = true
  record_enabled  = false

  domain_name = "example.com"
  vpc_id      = "vpc-066fec79cd29d4d2e"

  secondary_vpc_id = "vpc-07230de43f68fc88e"
}
