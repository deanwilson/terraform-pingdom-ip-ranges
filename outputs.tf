output cidr_blocks {
  description = "List of Pingdom CIDR ranges"
  value       = "${local.formatted_ranges}"
}
