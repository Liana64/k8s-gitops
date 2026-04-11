module "vm" {
  source      = "../../modules/proxmox-vm"
  target_node = "ms-01"

  name        = "talos-n1"
  vm_id       = 100
  cores       = 10
  memory      = 24576

  disks = [
    { size = 128 },
    { size = 755 },
  ]

  networks = [
    { bridge = "vmbr2", vlan_id = 10, mac_address = "BC:24:11:15:69:CB" },
    { bridge = "vmbr4", vlan_id = 10, mac_address = "BC:24:11:0D:E4:26" },
  ]

  smbios_uuid = "44960372-e9de-40e2-b1c3-0fd8799943a0"
}
