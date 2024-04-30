## YG Worker Nodes
resource "proxmox_virtual_environment_vm" "yg_worker" {
  count     = var.yg_worker_count
  name      = local.yg_worker_nodes[count.index].name
  node_name = var.proxmox_server

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  initialization {
    upgrade = false
    ip_config {
      ipv4 {
        address = "${local.yg_worker_nodes[count.index].address}/24"
        gateway = var.cluster_node_network_gateway
      }
    }

    user_account {
      username = "homelab"
      keys     = [trimspace(var.ssh_key)]
    }

  }


  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image_pve.id
    interface    = "virtio0"
    iothread     = true
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}

## Waji Talos Worker Nodes
resource "proxmox_virtual_environment_vm" "waji_worker" {
  count           = var.waji_worker_count
  name            = local.waji_worker_nodes[count.index].name
  node_name       = var.proxmox_server
  stop_on_destroy = true
  bios            = "ovmf"
  machine         = "q35"
  scsi_hardware   = "virtio-scsi-single"
  operating_system {
    type = "l26"
  }
  cpu {
    type  = "host"
    cores = 4
  }
  memory {
    dedicated = 8 * 1024
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
    size         = 40
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
        address = "${local.waji_worker_nodes[count.index].address}/24"
        gateway = var.cluster_node_network_gateway
      }
    }
  }
}