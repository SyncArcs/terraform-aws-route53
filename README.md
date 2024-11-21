# terraform-aws-route53

# Terraform AWS Cloud route53 Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [License](#license)
- [Author](#Author)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
Terraform module to create Route53 resource on AWS for zone and record set.
## Usage
To use this module, you should have Terraform installed and configured for AWS. This module provides the necessary Terraform configuration for creating AWS resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

Here are some examples of how you can use this module in your inventory structure:
### Public Hostedzone
```hcl
  module "route53" {
    source         = "git::https://github.com/SyncArcs/terraform-aws-route53.git?ref=v1.0.0"
    name           = "route53"
    environment    = "test"
    label_order    = ["environment", "name"]
    public_enabled = true
    record_enabled = true
    domain_name    = "syncArcs.com"
    names          = [
                      "www.",
                      "admin."
                    ]
    types          = [
                      "A",
                      "CNAME"
                    ]
    alias          = {
                      names = [
                        "d130easdflja734js.cloudfront.net"
                      ]
                      zone_ids = [
                        "Z2FDRFHATA1ER4"
                      ]
                      evaluate_target_healths = [
                        false
                      ]
                    }
  }
```
### Private Hostedzone
```hcl
  module "route53" {
    source          = "git::https://github.com/SyncArcs/terraform-aws-route53.git?ref=v1.0.0"
    name            = "route53"
    environment     = "test"
    label_order     = ["environment", "name"]
    private_enabled = true
    record_enabled  = true
    domain_name     = "syncArcs.com"
    vpc_id          = "vpc-xxxxxxxxxxxxx"
    names           = [
                      "www.",
                      "admin."
                     ]
    types           = [
                      "A",
                      "CNAME"
                     ]
    ttls            = [
                      "3600",
                      "3600",
                     ]
    values          = [
                      "10.0.0.27",
                      "mydomain.com",
                     ]
  }
```
### Vpc Association
```hcl
  module "route53" {
    source               = "git::https://github.com/SyncArcs/terraform-aws-route53.git?ref=v1.0.0"
    name                 = "route53"
    environment          = "test"
    label_order          = ["environment", "name"]
    private_enabled      = true
    enabled              = true
    domain_name          = "syncArcs.com"
    vpc_id               = "vpc-xxxxxxxxxxxxx"
    secondary_vpc_id     = "vpc-xxxxxxxxxxxxx"
    secondary_vpc_region = "eu-west-1"
  }
```



## Examples
For detailed examples on how to use this module, please refer to the [examples](https://github.com/SyncArcs/terraform-aws-route53/tree/master/example) directory within this repository.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/SyncArcs/terraform-aws-route53/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace **MIT** and **SyncArcs** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/SyncArcs/terraform-aws-labels.git | v1.0.0 |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alias | An alias block. Conflicts with ttl & records. Alias record documented below. | list | `<list>` | no |
| allow_overwrites | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. | list | `<list>` | no |
| attributes | Additional attributes (e.g. `1`). | list | `<list>` | no |
| comment | A comment for the hosted zone. Defaults to 'Managed by Terraform'. | string | `` | no |
| delegation_set_id | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones. | string | `` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | string | `-` | no |
| domain_name | This is the name of the resource. | string | - | yes |
| enabled | Whether to create Route53 vpc association. | bool | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | string | `` | no |
| failover_enabled | Whether to create Route53 record set. | bool | `false` | no |
| failover_routing_policies | A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below. | string | `` | no |
| force_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | bool | `true` | no |
| geolocation_enabled | Whether to create Route53 record set. | bool | `false` | no |
| geolocation_routing_policies | A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below. | string | `` | no |
| health_check_ids | The health check the record should be associated with. | list | `<list>` | no |
| label_order | Label order, e.g. `name`,`application`. | list | `<list>` | no |
| latency_enabled | Whether to create Route53 record set. | bool | `false` | no |
| latency_routing_policies | A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below. | string | `` | no |
| multivalue_answer_routing_policies | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. | list | `<list>` | no |
| name | Name  (e.g. `app` or `cluster`). | string | `` | no |
| names | The name of the record. | list | `<list>` | no |
| private_enabled | Whether to create private Route53 zone. | bool | `false` | no |
| public_enabled | Whether to create public Route53 zone. | bool | `false` | no |
| record_enabled | Whether to create Route53 record set. | bool | `false` | no |
| record_set_enabled | Whether to create seperate Route53 record set. | bool | `false` | no |
| secondary_vpc_id | The VPC to associate with the private hosted zone. | string | `` | no |
| secondary_vpc_region | The VPC's region. Defaults to the region of the AWS provider. | string | `` | no |
| set_identifiers | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. | list | `<list>` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | map | `<map>` | no |
| ttls | (Required for non-alias records) The TTL of the record. | list | `<list>` | no |
| types | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | list | `<list>` | no |
| values | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add "" inside the Terraform configuration string (e.g. "first255characters""morecharacters"). | list | `<list>` | no |
| vpc_id | VPC ID. | string | `` | no |
| weighted_enabled | Whether to create Route53 record set. | bool | `false` | no |
| weighted_routing_policies | A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below. | string | `` | no |
| zone_id | Zone ID. | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| tags | A mapping of tags to assign to the resource. |
| zone_id | The Hosted Zone ID. This can be referenced by zone records. |


