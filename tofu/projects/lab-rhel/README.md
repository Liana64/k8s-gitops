# lab-rhel

These VMs are for Red Hat Certified Architect (RHCA) exams, see more info on [my notes repository](https://github.com/Liana64/RHCA).

## Usage

Place qcow2 files in `images` and then set `TF_VAR_proxmox_endpoint`, `TF_VAR_proxmox_username`, `TF_VAR_proxmox_password`, and `TF_VAR_ssh_public_keys` before running `tofu plan`/`apply`. Default admin user is `cloud-user`; you can also (optionally) pin image checksums with `TF_VAR_qcow2_checksums='{"10.1":"<sha256>"}'`.

Download RHEL images from [access.redhat.com](https://access.redhat.com/) with a (free) Red Hat Developer Subscription.

**Defined images**
- `rhel-8.4-x86_64-kvm.qcow2`
- `rhel-9.2-x86_64-kvm.qcow2`
- `rhel-10.1-x86_64-kvm.qcow2`
