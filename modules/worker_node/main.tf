resource "proxmox_virtual_environment_vm" "wa-worker01" {
  name = "wa-worker01"
  node_name = var.proxmox_server

  cpu {
    cores = 3
  }

  memory {
    dedicated = 4096
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.44/24"
        gateway = "192.168.219.1"
      }
    }

    user_account {
      username = "homelab"
      keys = [trimspace(var.ssh_key)]
    }
  }


  disk {
    datastore_id = "local-lvm"
    file_id = var.ubuntu_image_file_id
    interface = "virtio0"
    iothread = true
    size = 30
  }

  network_device {
    bridge = "vmbr0"
  }
}