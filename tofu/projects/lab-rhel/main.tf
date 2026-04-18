
locals {
  iso_map = {
    "8.4"  = "local:iso/rhel-8.4-x86_64-boot.iso"
    "9.2"  = "local:iso/rhel-9.2-x86_64-boot.iso"
    "10.1" = "local:iso/rhel-10.1-x86_64-boot.iso"
  }

  rhel_major = split(".", var.rhel_version)[0]
  vm_name    = "lab-rhel${local.rhel_major}-${var.target_node}"
}

module "vm" {
  source      = "../../modules/proxmox-vm"
  target_node = var.target_node
  iso         = local.iso_map[var.rhel_version]

  name   = local.vm_name
  vm_id  = var.vm_id
  cores  = 2
  memory = 1536

  disks    = [{ size = 20 }]
  networks = [{ bridge = "vmbr1", vlan_id = 80 }]
}

output "vm_id" {
  value = module.vm.vm_id
}

output "vm_name" {
  value = local.vm_name
}
