/**
* ## pingdom_ip_ranges
*
* A data module for retrieving Pingdoms current IPv4 or IPv6
* address ranges.
*
* This module fetches the ranges from Pingdom itself and exposes them
* as outputs.
*
*/

locals {
  # lowercase everything and remove whitespace
  proto = "${lower(trimspace(var.protocol))}"

  single_host_cidr = "${local.proto == "ipv4" ? "32" : "128"}"

  ranges           = "${split("\n", data.http.pingdom_ranges.body)}"
  formatted_ranges = "${sort(formatlist("%s/%s", compact(local.ranges), local.single_host_cidr))}"
}

data "http" "pingdom_ranges" {
  url = "https://my.pingdom.com/probes/${var.protocol}"

  request_headers {
    "Accept" = "application/json"
  }
}
