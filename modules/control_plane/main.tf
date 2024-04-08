resource "proxmox_virtual_environment_vm" "master01" {
  name = "master01"
  node_name = var.proxmox_mini1

  cpu {
    cores = 4
  }

  memory {
    dedicated = 14336
  }

  initialization {
  
    ip_config {
      ipv4 {
        address = "192.168.219.41/24"
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
    file_id = var.ubuntu_image_file1_id
    interface = "virtio0"
    iothread = true
    size = 27
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_vm" "master02" {
  name = "master02"
  node_name = var.proxmox_mini2

  cpu {
    cores = 4
  }

  memory {
    dedicated = 14336
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.42/24"
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
    file_id = var.ubuntu_image_file2_id
    interface = "virtio0"
    iothread = true
    size = 27
  }

  network_device {
    bridge = "vmbr0"
  }
}


resource "proxmox_virtual_environment_vm" "master03" {
  name = "master03"
  node_name = var.proxmox_mini3

  cpu {
    cores = 3
  }

  memory {
    dedicated = 14336
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.43/24"
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
    file_id = var.ubuntu_image_file3_id
    interface = "virtio0"
    iothread = true
    size = 27
  }

  network_device {
    bridge = "vmbr0"
  }
}