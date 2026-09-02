output "ipv4_address" {
  description = "Primary public IPv4 address of the host"
  value       = hcloud_server.this.ipv4_address
}

output "ipv6_address" {
  description = "Primary public IPv6 address of the host"
  value       = hcloud_server.this.ipv6_address
}