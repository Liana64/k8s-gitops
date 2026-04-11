module "vm" {
  source       = "../../modules/proxmox-vm"
  target_node  = "n3"

  name         = "talos-n3"
  vm_id        = 100
  cores        = 4
  memory       = 3584
  datastore_id = "local-ssd"

  disks = [
    { size = 128 },
    { size = 512 },
  ]

  networks = [
    { bridge = "vmbr1", vlan_id = 10, mac_address = "BC:24:11:E9:CB:66" },
  ]

  smbios_uuid = "c4056b75-6e4d-4b4a-b83b-7c2b9c561702"
}
