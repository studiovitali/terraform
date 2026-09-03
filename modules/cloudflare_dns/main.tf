terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = { source = "cloudflare/cloudflare", version = "~> 5.24.0" }
  }
}

data "cloudflare_zone" "this" {
  filter = {
    name = var.zone_name
  }
}

resource "cloudflare_dns_record" "this" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.record_name
  type    = var.record_type
  content = var.record_value
  proxied = var.cloudflare_proxied
  ttl     = var.cloudflare_proxied ? 1 : var.record_ttl
}