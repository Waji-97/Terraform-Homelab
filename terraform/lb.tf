## Load Balancer
resource "proxmox_virtual_environment_vm" "ksg_lb" {
  name = "ksg_lb"
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
        address = "192.168.219.50/24"
        gateway = var.cluster_node_network_gateway
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
    host = "192.168.219.50/24"
  }
    source = "/home/homelab/ksg-local-lb-setup.sh"
    destination = "/home/homelab/local-lb-setup.sh"     
  }

  provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "homelab"
    private_key = "${file("/home/homelab/.ssh/id_rsa")}"
    host = "192.168.219.50/24"
  }
    inline = [
      "sudo /bin/bash local-lb-setup.sh"
    ]    
  }
}