resource "proxmox_virtual_environment_file" "talos" {
  datastore_id = "local"
  node_name    = "pve"
  content_type = "iso"
  source_file {
    path      = "/home/homelab/nocloud-amd64.qcow2"
    file_name = "nocloud-amd64.img"
  }
}

resource "proxmox_virtual_environment_vm" "controller" {
  name            = "test"
  node_name       = "pve"
  stop_on_destroy = true
  bios            = "ovmf"
  machine         = "q35"
  scsi_hardware   = "virtio-scsi-single"
  operating_system {
    type = "l26"
  }
  cpu {
    type  = "host"
    cores = 2
  }
  memory {
    dedicated = 2 * 1024
  }
  vga {
    type = "qxl"
  }
  network_device {
    bridge = "vmbr0"
  }
  tpm_state {
    version = "v2.0"
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
    file_format  = "raw"
    file_id      = proxmox_virtual_environment_file.talos.id
  }
  agent {
    enabled = true
    trim    = true
  }
  initialization {
    ip_config {
      ipv4 {
        address = "192.168.219.67/24"
        gateway = "192.168.219.1"
      }
    }
  }
}
