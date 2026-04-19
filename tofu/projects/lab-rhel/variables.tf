
variable "rhel_version" {
  type        = string
  description = "RHEL version. Must have a matching qcow2 file in ./images/."
  default     = "10.1"

  validation {
    condition     = contains(["8.4", "9.2", "10.1"], var.rhel_version)
    error_message = "Supported versions: 8.4, 9.2, 10.1. Add more to qcow2_filename_map in main.tf."
  }
}

variable "target_node" {
  type    = string
  default = "n3"
}

variable "vm_id" {
  type    = number
  default = 400
}

variable "ssh_public_keys" {
  type        = list(string)
  description = "SSH public keys to inject via cloud-init."
}

variable "admin_username" {
  type    = string
  default = "cloud-user"
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = null
}

variable "image_datastore_id" {
  type    = string
  default = "local"
}

variable "qcow2_checksums" {
  type        = map(string)
  default     = {}
  description = "Optional sha256 checksums keyed by rhel_version, e.g. { \"10.1\" = \"<hex>\" }."
}

variable "ip_config" {
  type = object({
    ipv4_address = optional(string, "dhcp")
    ipv4_gateway = optional(string)
  })
  default = {}
}
