module "talos" {
  source   = "../../modules/proxmox-vm"
  for_each = var.nodes

  name         = "talos-${each.key}"
  target_node  = each.value.target_node
  vm_id        = each.value.vm_id
  cores        = each.value.cores
  memory       = each.value.memory
  datastore_id = each.value.datastore_id
  disks        = each.value.disks
  networks     = each.value.networks
  hostpci      = each.value.hostpci
  smbios_uuid  = each.value.smbios_uuid
}

output "vm_ids" {
  value = { for k, m in module.talos : k => m.vm_id }
}

output "ipv4_addresses" {
  value = { for k, m in module.talos : k => m.ipv4_addresses }
}
