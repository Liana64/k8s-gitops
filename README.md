# 🧪 k8s-gitops

**Liana Laboratories Self-Hosting Initiative**

This is my Kubernetes homelab, currently running on a Lenovo ThinkServer RD350. I'm still migrating over some of my resources to Kubernetes, and I also want to setup another node on my R720xd, but this is the current state of things! Feel free to have a look around and adapt however you want!

**Are you an aspiring homelabber?**

Have a look at onedr0p's [cluster-template](https://github.com/onedr0p/cluster-template), [kubesearch](https://kubesearch.dev/), and [selfh.st](https://selfh.st/) for inspiration!

## 📌 Features

- [Talos](https://github.com/fluxcd/flux2) OS for immutability, security, performance, ease-of-use. For my homelab, I've deployed this on Proxmox so I'm using nocloud, but for a bare metal install there are a lot of great tools you can use
- Automation, including [Flux GitOps](https://github.com/fluxcd/flux2), [Reloader](https://github.com/stakater/Reloader), and other deployments
- Local OCI registry mirror using [spegel](https://github.com/spegel-org/spegel)
- [Cert-manager](https://github.com/cert-manager/cert-manager) with LetsEncrypt and DNS authorization
- [Cilium](https://github.com/cilium/cilium) container networking and CoreDNS
- Secrets encrypted using [SOPS](https://github.com/getsops/sops) and stored with git (I don't think there are enough qubits for this to ever matter, but if I'm wrong, oh well!)
- OIDC authentication with [Authelia](https://github.com/authelia/authelia) and [LLDAP](https://github.com/lldap/lldap)
- [Traefik](https://github.com/traefik/traefik) ingresses with security measures
- Databases for [Cloudnative PG](https://github.com/cloudnative-pg/cloudnative-pg), [MinIO](https://min.io/), [Dragonfly](https://github.com/dragonflydb/dragonfly), and even [MS SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)!
- Storage using [OpenEBS](https://github.com/openebs/openebs) (I didn't have great experiences with NVMe over TCP, i.e. Mayastor, but that might go differently for you. Also, maybe that was just related to the Talos v1.8.2 kernel panic on nocloud bug)
- Observability tools and exporters including Prometheus, Grafana, Loki, and others
- Many self-hosted deployments, including a [Homepage](https://github.com/gethomepage/homepage)
- Taskfiles ([go-task](https://taskfile.dev/)) and scripts for ease-of-use

## ✅ Requirements

- [Taskfile](https://taskfile.dev/)
- [Direnv](https://github.com/direnv/direnv)
- [Talosctl](https://github.com/siderolabs/talos)
- [Talhelper](https://github.com/budimanjojo/talhelper)
- [SOPS](https://github.com/getsops/sops)
- [age](https://github.com/FiloSottile/age)

## 🏆 Credit

Thank you [bjw-s](https://github.com/bjw-s/helm-charts) for the incredible app-template helmchart, and [brettinternet](https://github.com/brettinternet/homeops) for so much inspiration, and for making your taskfiles/scripts/helmfile publically available for adaptation!
