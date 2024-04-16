resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image_pve" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.proxmox_server

  url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image_mini1" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.proxmox_mini1

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image_mini2" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.proxmox_mini2

  url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image_mini3" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.proxmox_mini3

  url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

