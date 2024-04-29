resource "proxmox_virtual_environment_vm" "example" {
  name      = "test-talos"
  node_name = "pve"
  started = false
  bios = "ovmf"
  scsi_hardware   = "virtio-scsi-single"
  operating_system {
    type = "l26"
  }

  clone {
    vm_id = 3000
  }

  tpm_state {
    version = "v2.0"
  }

  agent {
    enabled = true
    trim    = true
  }

  machine = "q35"
 
  memory {
    dedicated = 2048
  }

  cpu {
    type = "x86-64-v2-AES"
    cores = 2
  }

  vga {
    type = "qxl"
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    discard      = "on"
    size         = 20
    file_format = "raw"
  }

  initialization {
    dns {
      servers = [
        "1.214.68.2",
        "61.41.153.2"
      ]
    }
    ip_config {
      ipv4 {
        address = "192.168.219.32/24"
        gateway = "192.168.219.1"
      }
    }
  }
}
