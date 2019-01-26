module "pingdom_ranges" {  
  source = "github.com/deanwilson/terraform-pingdom-ip-ranges"
  protocol = "ipv4"
}

provider "cloudflare" {
 # https://www.terraform.io/docs/providers/cloudflare/index.html
}

resource "cloudflare_access_rule" "whitelist_pingdom_ips" {
  count = "${length(module.pingdom_ranges.cidr_blocks)}"
  notes = "Requests coming from pingdom"
  mode = "whitelist"
  configuration {
    target = "ip_range"
    value = "${element(module.pingdom_ranges.cidr_blocks, count.index)}"
  }
  zone = "${var.zone}"
}