resource "proxmox_virtual_environment_vm" "worker" {
  count = var.worker_count
  name = "${local.worker_nodes[count.index].name}"
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
        address = "${local.worker_nodes[count.index].address}/24"
        gateway = var.cluster_node_network_gateway
      }
    }

    user_account {
      username = "homelab"
      keys = [trimspace(var.ssh_key)]
    }

  }


  disk {
    datastore_id = "local-lvm"
    file_id = var.ubuntu_image_file1_id
    interface = "virtio0"
    iothread = true
    size = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}