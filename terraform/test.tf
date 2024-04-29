resource "proxmox_virtual_environment_vm" "example" {
  name      = "test-talos"
  node_name = "pve"
  bios = "ovmf"

  clone {
    vm_id = 3000
  }

  machine = "q35"

  operating_system {
    type = "l26"
  }

  cpu {
    type = "host"
    cores = 2
  }

  memory {
    dedicated = 2 * 1024
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    discard      = "on"
    size         = 20
    file_format  = "raw"
  }

  agent {
    enabled = true
    trim    = true
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
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
