module "vm" {
  source       = "../../modules/proxmox-vm"
  target_node  = "n2"

  name         = "talos-n2"
  vm_id        = 100
  cores        = 14
  memory       = 26624
  datastore_id = "local-mirror"

  disks = [
    { size = 128 },
    { size = 1280 },
  ]

  networks = [
    { bridge = "vmbr2", vlan_id = 10, mac_address = "BC:24:11:C7:0F:C6" },
    { bridge = "vmbr1", vlan_id = 10, mac_address = "BC:24:11:25:31:59" },
  ]

  hostpci = [
    { mapping = "GTX_1080", pcie=true },
  ]

  smbios_uuid = "efd7776f-3f94-425d-bcb8-e2613708f4d1"
}
