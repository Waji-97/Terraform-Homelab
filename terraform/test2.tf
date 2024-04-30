resource "proxmox_virtual_environment_vm" "test-vm" {
    name      = "test-vm"
    node_name = "pve"
  
  
    cpu {
      cores = 2
    }
  
    memory {
      dedicated = 2048
    }
  
    disk {
      datastore_id = "local-lvm"
      file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image_pve.id
      interface    = "virtio0"
      iothread     = true
      discard      = "on"
      size         = 20
    }
  
    initialization {
      ip_config {
        ipv4 {
            address = "192.168.219.11/24"
            gateway = "192.168.219.1"
        }
      }
  
      user_account {
        username = "homelab"
        keys     = [trimspace(var.ssh_key)]
      }
    }
    network_device {
      bridge = "vmbr0"
    } 
  }
