module "pingdom_ranges" {
  # defaults to fetching ipv4 ranges
  source = "github.com/deanwilson/terraform-pingdom-ip-ranges"
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
