resource "proxmox_virtual_environment_vm" "lb" {
  name = "lb01"
  node_name = var.proxmox_server

  cpu {
    cores = 1
  }

  memory {
    dedicated = 2048
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.30/24"
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
    size = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}
