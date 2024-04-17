resource "proxmox_virtual_environment_vm" "lb01" {
  name = "lb01"
  node_name = var.proxmox_server

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.219.40/24"
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

  provisioner "file" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.40"
  }
    source = "/home/homelab/local-lb-setup.sh"
    destination = "/home/homelab/local-lb-setup.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.40"
  }
    inline = [
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt update -o Acquire::CompressionTypes::Order::=gz",
      "sudo apt upgrade -y",
      "sudo /bin/bash local-lb-setup.sh"
    ]    
  }
}
