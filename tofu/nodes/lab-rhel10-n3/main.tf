module "vm" {
  source      = "../../modules/proxmox-vm"
  target_node = "n3"
  iso = "local:iso/rhel-10.1-x86_64-boot.iso"

  name        = "lab-rhel10-n3"
  vm_id       = 200
  cores       = 2
  memory      = 1536

  disks = [
    { size = 20 },
  ]

  networks = [
    { bridge = "vmbr1", vlan_id = 80 },
  ]
}
