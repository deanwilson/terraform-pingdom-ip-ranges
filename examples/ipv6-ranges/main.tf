module "pingdom_ranges" {
  # request IPv6 ranges
  source   = "github.com/deanwilson/terraform-pingdom-ip-ranges"
  protocol = "ipv6"
}

resource "aws_security_group" "from_pingdom" {
  name = "from_pingdom"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["${module.pingdom_ranges.cidr_blocks}"]
  }
}
