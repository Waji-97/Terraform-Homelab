resource "proxmox_virtual_environment_vm" "worker01" {
  name = "worker01"
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.50/24"
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

resource "proxmox_virtual_environment_vm" "worker02" {
  name = "worker02"
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.51/24"
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

resource "proxmox_virtual_environment_vm" "worker03" {
  name = "worker03"
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.52/24"
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

