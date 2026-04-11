variable "name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "cores" {
  type    = number
  default = 10
}

variable "sockets" {
  type    = number
  default = 1
}

variable "cpu_type" {
  type    = string
  default = "x86-64-v2-AES"
}

variable "memory" {
  type    = number
  default = 24576
}

variable "iso" {
  type    = string
  default = "local:iso/nocloud-amd64-secureboot.iso"
}

variable "datastore_id" {
  type    = string
  default = "local-pool"
}

variable "disks" {
  type = list(object({
    size = number
    ssd  = optional(bool, true)
    aio  = optional(string, "native")
  }))
  default = [{ size = 128 }]
}

variable "networks" {
  type = list(object({
    bridge      = string
    vlan_id     = optional(number)
    firewall    = optional(bool, true)
    mac_address = optional(string)
  }))
}

variable "startup_order" {
  type    = string
  default = "10"
}

variable "smbios_uuid" {
  type    = string
  default = null
}

variable "on_boot" {
  type    = bool
  default = true
}

variable "serial_device" {
  type    = string
  default = null
}
