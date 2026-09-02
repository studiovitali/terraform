terraform {
  required_version = ">= 1.0.0"
  required_providers {
    hcloud = { source = "hetznercloud/hcloud", version = "~> 1.68.0" }
  }
}

locals {
  # single naming scheme - propagates everywhere
  ssh_key_name  = "${var.project_name}-key"
  firewall_name = "${var.project_name}-fw"
}

resource "hcloud_ssh_key" "this" {
  name       = local.ssh_key_name
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
  name         = var.project_name
  image        = var.hcloud_image
  server_type  = var.hcloud_server_type
  location     = var.hcloud_location
  user_data    = var.init_user_data
  firewall_ids = [hcloud_firewall.this.id]
}