resource "proxmox_virtual_environment_vm" "worker01" {
  name = "worker01"
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
        address = "192.168.1.44/24"
        gateway = "192.168.1.1"
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
    bridge = "vmbr8"
  }
}

resource "proxmox_virtual_environment_vm" "worker02" {
  name = "worker02"
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
        address = "192.168.1.45/24"
        gateway = "192.168.1.1"
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
    bridge = "vmbr8"
  }
}



resource "proxmox_virtual_environment_vm" "usr_worker01" {
  name = "usrworker01"
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
        address = "192.168.2.54/24"
        gateway = "192.168.2.1"
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
    bridge = "vmbr9"
  }
}

resource "proxmox_virtual_environment_vm" "usr_worker02" {
  name = "usrworker02"
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
        address = "192.168.2.55/24"
        gateway = "192.168.2.1"
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
    bridge = "vmbr9"
  }
}