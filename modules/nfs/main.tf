resource "proxmox_virtual_environment_vm" "nfs" {
  name = "nfs"
  node_name = var.proxmox_server


  cpu {
    cores = 1
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    file_id = var.ubuntu_image_file_id
    interface = "virtio0"
    iothread = true
    size = 500
  }


  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.20/24"
        gateway = "192.168.219.1"
      }
    }

    user_account {
      username = "homelab"
      keys = [trimspace(var.ssh_key)]
    }
  }

  network_device {
    bridge = "vmbr0"
  }
}
