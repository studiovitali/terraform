variable "project_name" {
  type        = string
  description = "Project / host name"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key to manage the host"
}

variable "hcloud_server_type" {
  type        = string
  description = "Hetzner server type (e.g. cx22)"
}

variable "hcloud_image" {
  type        = string
  description = "OS image to boot (e.g. debian-13)"
}

variable "hcloud_location" {
  type        = string
  description = "Hetzner location (fsn1, nbg1, hel1, ash1)"
  validation {
    condition     = contains(["fsn1", "nbg1", "hel1", "ash1"], var.hcloud_location)
    error_message = "location must be one of fsn1, nbg1, hel1, ash1"
  }
}

variable "init_user_data" {
  type        = string
  description = "Pre-rendered cloud-init user data (optional)"
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