provider "aws" {
  region = "us-east-1"
}

module "route53" {
  source = "../../"

  name            = "route53"
  environment     = "test"
  label_order     = ["environment", "name"]
  private_enabled = true
  record_enabled  = true

  domain_name = "example.com"
  vpc_id      = "vpc-03acb4bc65dc34666" # VPC ID to associate

  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 3600
      records = ["10.0.0.27"]
    },
    {
      name    = "admin"
      type    = "CNAME"
      ttl     = 3600
      records = ["mydomain.com"]
    },
  ]
}
