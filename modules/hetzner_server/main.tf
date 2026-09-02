terraform {
  required_version = ">= 1.0.0"
  required_providers {
    hcloud = { source = "hetznercloud/hcloud", version = "~> 1.68.0" }
  }
}

locals {
  # single naming scheme - propagates everywhere
  key_name      = "${var.name}-key"
  firewall_name = "${var.name}-fw"
}

resource "hcloud_ssh_key" "this" {
  name       = local.key_name
  public_key = var.ssh_public_key
}

resource "hcloud_firewall" "this" {
  name = local.firewall_name

  dynamic "rule" {
    for_each = var.firewall_rules
    content {
      direction  = rule.value.direction
      protocol   = rule.value.protocol
      port       = rule.value.port
      source_ips = rule.value.source_ips
    }
  }
}

resource "hcloud_server" "this" {
  name         = var.name
  image        = var.image
  server_type  = var.server_type
  location     = var.location
  user_data    = var.user_data
  firewall_ids = [hcloud_firewall.this.id]
}