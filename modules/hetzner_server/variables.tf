variable "name" {
  type        = string
  description = "Host name (used as prefix for the SSH key and firewall)"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key to manage the host"
}

variable "server_type" {
  type        = string
  description = "Hetzner server type (e.g. cx22)"
}

variable "image" {
  type        = string
  description = "OS image to boot (e.g. debian-13)"
}

variable "location" {
  type        = string
  description = "Hetzner location (fsn1, nbg1, hel1, ash1)"
  default     = "nbg1"
  validation {
    condition     = contains(["fsn1", "nbg1", "hel1", "ash1"], var.location)
    error_message = "location must be one of fsn1, nbg1, hel1, ash1."
  }
}

variable "user_data" {
  type        = string
  description = "Pre-rendered cloud-init user data (optional). Caller renders it from a template."
  default     = null
}

variable "firewall_rules" {
  type = list(object({
    direction  = string
    protocol   = string
    port       = string
    source_ips = list(string)
  }))
  description = "Firewall rules applied to the host"
  default = []
}