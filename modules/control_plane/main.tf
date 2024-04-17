resource "proxmox_virtual_environment_vm" "wa-master01" {
  name = "wa-master01"
  node_name = var.proxmox_mini1

  cpu {
    cores = 3
  }

  memory {
    dedicated = 8096
  }

  initialization {
    upgrade = false
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
    size = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  provisioner "file" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.41"
  }
    source = "/home/homelab/k8s_init.sh"
    destination = "/home/homelab/k8s_init.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.41"
  }
    inline = [
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt update -o Acquire::CompressionTypes::Order::=gz",
      "sudo /bin/bash k8s_init.sh --version v1.28"
    ]    
  }
}

resource "proxmox_virtual_environment_vm" "wa-master02" {
  name = "wa-master02"
  node_name = var.proxmox_mini2

  cpu {
    cores = 3
  }

  memory {
    dedicated = 8096
  }

  initialization {
    upgrade = false
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
    size = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  provisioner "file" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.42"
  }
    source = "/home/homelab/k8s_init.sh"
    destination = "/home/homelab/k8s_init.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.42"
  }
    inline = [
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt update -o Acquire::CompressionTypes::Order::=gz",
      "sudo /bin/bash k8s_init.sh --version v1.28"
    ]    
  }
}


resource "proxmox_virtual_environment_vm" "wa-master03" {
  name = "wa-master03"
  node_name = var.proxmox_mini3

  cpu {
    cores = 3
  }

  memory {
    dedicated = 8096
  }

  initialization {
    upgrade = false
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
    size = 20
  }

  network_device {
    bridge = "vmbr0"
  }
  provisioner "file" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.43"
  }
    source = "/home/homelab/k8s_init.sh"
    destination = "/home/homelab/k8s_init.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.43"
  }
    inline = [
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt update -o Acquire::CompressionTypes::Order::=gz",
      "sudo /bin/bash k8s_init.sh --version v1.28"
    ]    
  }
}