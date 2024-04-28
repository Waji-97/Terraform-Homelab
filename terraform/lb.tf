## YG Load Balancer
resource "proxmox_virtual_environment_vm" "yg_lb" {
  name      = "yg-lb"
  node_name = var.proxmox_server

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  initialization {
    upgrade = false
    ip_config {
      ipv4 {
        address = "192.168.219.60/24"
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
