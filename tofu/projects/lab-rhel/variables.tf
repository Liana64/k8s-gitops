
variable "rhel_version" {
  type        = string
  description = "RHEL version to boot from ISO. Must have a matching ISO uploaded to Proxmox local storage."
  default     = "10.1"

  validation {
    condition     = contains(["8.4", "9.2", "10.1"], var.rhel_version)
    error_message = "Supported versions: 8.4, 9.2, 10.1. Add more to iso_map in main.tf."
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
