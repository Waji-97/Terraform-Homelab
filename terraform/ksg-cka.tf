resource "proxmox_virtual_environment_vm" "master_ubuntu_vm01" {
    name      = "ksg-cka-master01"
    node_name = "pve"
  
    agent {
      enabled = true
    }
  
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
            address = "192.168.219.55/24"
            gateway = "192.168.219.0/24"
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
  

  resource "proxmox_virtual_environment_vm" "worker_ubuntu_vm01" {
    name      = "ksg-cka-worker01"
    node_name = "pve"
  
    agent {
      enabled = true
    }
  
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
            address = "192.168.219.56/24"
            gateway = "192.168.219.0/24"
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



  resource "proxmox_virtual_environment_vm" "master_ubuntu_vm02" {
    name      = "ksg-cka-master02"
    node_name = "pve"
  
    agent {
      enabled = true
    }
  
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
            address = "192.168.219.57/24"
            gateway = "192.168.219.0/24"
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
  

  resource "proxmox_virtual_environment_vm" "worker_ubuntu_vm02" {
    name      = "ksg-cka-worker02"
    node_name = "pve"
  
    agent {
      enabled = true
    }
  
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
            address = "192.168.219.58/24"
            gateway = "192.168.219.0/24"
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
  