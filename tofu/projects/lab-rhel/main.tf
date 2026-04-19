locals {
  qcow2_filename_map = {
    "8.4"  = "rhel-8.4-x86_64-kvm.qcow2"
    "9.2"  = "rhel-9.2-x86_64-kvm.qcow2"
    "10.1" = "rhel-10.1-x86_64-kvm.qcow2"
  }

  qcow2_filename   = local.qcow2_filename_map[var.rhel_version]
  qcow2_local_path = "${path.module}/images/${local.qcow2_filename}"

  rhel_major = split(".", var.rhel_version)[0]
  vm_name    = "lab-rhel${local.rhel_major}-${var.target_node}"
}

resource "proxmox_virtual_environment_file" "rhel_qcow2" {
  content_type = "iso"
  datastore_id = var.image_datastore_id
  node_name    = var.target_node

  source_file {
    path      = local.qcow2_local_path
    file_name = local.qcow2_filename
    checksum  = lookup(var.qcow2_checksums, var.rhel_version, null)
  }
}

module "vm" {
  source      = "../../modules/proxmox-vm"
  target_node = var.target_node
  iso         = "none"

  name   = local.vm_name
  vm_id  = var.vm_id
  cores  = 2
  memory = 1536

  disks = [{
    size        = 20
    file_id     = proxmox_virtual_environment_file.rhel_qcow2.id
    file_format = "qcow2"
  }]

  networks = [{ bridge = "vmbr1", vlan_id = 80 }]

  cloud_init = {
    user_account = {
      username = var.admin_username
      password = var.admin_password
      keys     = var.ssh_public_keys
    }
    dns = { servers = ["1.1.1.1", "9.9.9.9"] }
    ip_config = [{
      ipv4 = {
        address = var.ip_config.ipv4_address
        gateway = var.ip_config.ipv4_gateway
      }
    }]
  }
}

output "vm_id" {
  value = module.vm.vm_id
}

output "vm_name" {
  value = local.vm_name
}

output "ipv4_addresses" {
  value = module.vm.ipv4_addresses
}
