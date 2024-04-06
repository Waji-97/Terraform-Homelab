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

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr8_mini1" {

  node_name = var.proxmox_mini1
  name      = "vmbr8"

  comment = "mgmt-k8s-network"

}

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr8_mini2" {

  node_name = var.proxmox_mini2
  name      = "vmbr8"

  comment = "mgmt-k8s-network"

}

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr8_mini3" {

  node_name = var.proxmox_mini3
  name      = "vmbr8"

  comment = "mgmt-k8s-network"

}