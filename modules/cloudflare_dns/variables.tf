variable "zone_name" {
  type        = string
  description = "Apex domain of the Cloudflare zone (e.g. domain.tld)"
}

variable "record_name" {
  type        = string
  description = "Subdomain label to create the record for (e.g. sub → sub.domain.tld)"
}

variable "record_type" {
  type        = string
  description = "DNS record type: A, AAAA, CNAME, MX, TXT"
}

variable "record_value" {
  type        = string
  description = "Record content (IP address, target hostname, text)"
}

variable "proxied" {
  type        = bool
  description = "Route through the Cloudflare proxy (orange cloud)"
  default     = true
}

variable "ttl" {
  type        = number
  description = "TTL in seconds (ignored when proxied)"
  default     = 3600
  validation {
    condition     = var.ttl >= 60 && var.ttl <= 86400
    error_message = "ttl must be between 60 and 86400 seconds"
  }
}