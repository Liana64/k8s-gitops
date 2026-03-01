# k8s-gitops

This is my kubernetes homelab, currently running on a cluster of MinisForum devices.

<details>
  <summary>Click here to see my high-level network diagram</summary>

  <img src="https://raw.githubusercontent.com/Liana64/k8s-gitops/refs/heads/main/docs/homelab.jpg" align="center" width="600px" alt="Network Diagram" />
</details>

## Features (Old)

- [Talos](https://github.com/siderolabs/talos) OS for immutability, security, performance, ease-of-use. For my homelab, I've deployed this on Proxmox so I'm using nocloud, but for a bare metal install there are a lot of great tools you can use
- Automation, including GitOps using [FluxCD](https://github.com/fluxcd/flux2), [Reloader](https://github.com/stakater/Reloader), and other deployments
- Local OCI registry mirror using [spegel](https://github.com/spegel-org/spegel)
- [Cert-manager](https://github.com/cert-manager/cert-manager) with LetsEncrypt and DNS authorization
- [Cilium](https://github.com/cilium/cilium) container networking and CoreDNS
- Secrets encrypted using [SOPS](https://github.com/getsops/sops) and stored with git (I don't think there are enough qubits for this to ever matter, but if I'm wrong, oh well!)
- OIDC authentication with [Authelia](https://github.com/authelia/authelia) and [LLDAP](https://github.com/lldap/lldap)
- [Traefik](https://github.com/traefik/traefik) ingresses with security measures
- Databases for [Cloudnative PG](https://github.com/cloudnative-pg/cloudnative-pg), [MinIO](https://min.io/), [Dragonfly](https://github.com/dragonflydb/dragonfly), and even [MS SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)!
- Storage using [OpenEBS](https://github.com/openebs/openebs) (I didn't have great experiences with NVMe over TCP, i.e. Mayastor, but that might go differently for you. Also, maybe that was just related to the Talos v1.8.2 kernel panic on nocloud bug). I haven't moved over to Rook Ceph yet, but it's also included.
- Various drivers and utilities
- Observability tools and exporters including Prometheus, Grafana, Loki, and others
- Many self-hosted deployments, including a [Homepage](https://github.com/gethomepage/homepage), game servers, and a media stack
- Taskfiles ([go-task](https://taskfile.dev/)) and scripts for ease-of-use

## Requirements

- [Taskfile](https://taskfile.dev/)
- [Direnv](https://github.com/direnv/direnv)
- [Talosctl](https://github.com/siderolabs/talos)
- [Talhelper](https://github.com/budimanjojo/talhelper)
- [SOPS](https://github.com/getsops/sops)
- [age](https://github.com/FiloSottile/age)

## Credit

- [bjw-s](https://github.com/bjw-s/helm-charts) for app-template
- [brettinternet](https://github.com/brettinternet/homeops) for inspiration
- [onedr0p](https://github.com/onedr0p/home-ops) for inspiration
