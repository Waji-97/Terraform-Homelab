variable "proxmox_server" {
    type = string
}

variable "ssh_key" {
  type = string
  sensitive = true
}

variable "ubuntu_image_file_id" {
  type = string
}

