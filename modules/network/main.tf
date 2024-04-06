resource "proxmox_virtual_environment_network_linux_bridge" "vmbr8" {

  node_name = var.proxmox_server
  name      = "vmbr8"

  comment = "mgmt-k8s-network"

}

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr9" {

  node_name = var.proxmox_server
  name      = "vmbr9"

  comment = "usr-k8s-network"

}