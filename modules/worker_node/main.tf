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
    upgrade = false
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
  provisioner "file" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.44"
  }
    source = "/home/homelab/k8s_init.sh"
    destination = "/home/homelab/k8s_init.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.44"
  }
    inline = [
      "sudo /bin/bash k8s_init.sh --version v1.28"
    ]    
  }
}

## ksg
resource "proxmox_virtual_environment_vm" "ksg-worker01" {
  name = "ksg-worker01"
  node_name = var.proxmox_server

  cpu {
    cores = 3
  }

  memory {
    dedicated = 4096
  }

  initialization {
    upgrade = false
    ip_config {
      ipv4 {
        address = "192.168.219.54/24"
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
