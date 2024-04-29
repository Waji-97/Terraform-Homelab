resource "proxmox_virtual_environment_vm" "example" {
  name      = "test-talos"
  node_name = "pve"
  started = false
  reboot = true

  clone {
    vm_id = 3000
  }

  machine = "q35"
 
  memory {
    dedicated = 2048
  }

  cpu {
    cores = 2
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.219.32/24"
        gateway = "192.168.219.1"
      }
    }
  }
}
