## KSG Cluster Node Resources
resource "proxmox_virtual_environment_vm" "ksg_master" {
  count     = var.ksg_master_count
  name      = local.ksg_master_nodes[count.index].name
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  initialization {
    upgrade = false
    ip_config {
      ipv4 {
        address = "${local.ksg_master_nodes[count.index].address}/24"
        gateway = var.cluster_node_network_gateway
      }
    }

    user_account {
      username = "homelab"
      keys     = [trimspace(var.ssh_key)]
    }

  }


  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image_pve.id
    interface    = "virtio0"
    iothread     = true
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}

## YG Master Nodes
resource "proxmox_virtual_environment_vm" "yg_master" {
  count     = var.yg_master_count
  name      = local.yg_master_nodes[count.index].name
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  initialization {
    upgrade = false
    ip_config {
      ipv4 {
        address = "${local.yg_master_nodes[count.index].address}/24"
        gateway = var.cluster_node_network_gateway
      }
    }

    user_account {
      username = "homelab"
      keys     = [trimspace(var.ssh_key)]
    }

  }


  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image_pve.id
    interface    = "virtio0"
    iothread     = true
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}
