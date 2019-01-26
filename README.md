# terraform-pingdom-ip-ranges

Use the Pingdom Probes IP ranges in your terraform code

## Usage

*THIS MODULE REQUIRES YOU TO HAVE SECURITY GROUPS THAT ALLOW MORE THAN 50 RULES*

The most basic use of this module fetches the IPv4 ranges used by Pingdoms
probes and only requires the `source` line to be provided.

```
module "pingdom_ranges" {
  source = "github.com/deanwilson/terraform-pingdom-ip-ranges"
}

```

Once you have the ranges you can allow them to connect to your services using
other terraform resources. Here we create an Amazon Web Services security group
that permits Pingdom to connect via port 443. If you have the default AWS SG
rule limit of 50 per group then this will fail due to the number of probe
addresses pingdom use.

```
resource "aws_security_group" "from_pingdom" {
  name = "from_pingdom"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["${module.pingdom_ranges.cidr_blocks}"]
  }
}
```

This module only accepts a single parameter, `protocol`, which can be set to
`ipv6` or `ipv4` (the default). You can see this usages, and some others in the
[examples](/examples) directory. My initial version of this module allowed
specifying a combination of protocol versions in as a list but the lack of true
conditionals made the `locals` code section horrendous and I'd rather just call
it twice.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| protocol | IP protocol version to fetch CIDR ranges for. ipv4 or ipv6 | string | `ipv4` | no |

## Outputs

| Name | Description |
|------|-------------|
| cidr_blocks | List of Pingdom CIDR ranges |

## Examples
examples directory contains working examples for AWS and Cloudflare access rules.

### Author

[Dean Wilson](https://www.unixdaemon.net)

### License

This module is released under the Mozilla Public License 2.0, the
same license as Terraform itself.
