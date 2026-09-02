output "ipv4_address" {
  description = "Primary public IPv4 address of the host"
  value       = hcloud_server.this.ipv4_address
}

output "ipv6_address" {
  description = "Primary public IPv6 address of the host"
  value       = hcloud_server.this.ipv6_address
}

output "server_id" {
  description = "Hetzner server ID"
  value       = hcloud_server.this.id
}

output "ssh_key_name" {
  description = "Name of the registered Hetzner SSH key"
  value       = hcloud_ssh_key.this.name
}

output "firewall_name" {
  description = "Name of the firewall attached to the host"
  value       = hcloud_firewall.this.name
}