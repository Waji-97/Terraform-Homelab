variable "proxmox_mini1" {
    type = string
}

variable "proxmox_mini2" {
    type = string
}

variable "proxmox_mini3" {
    type = string
}

variable "ssh_key" {
  type = string
  sensitive = true
}

variable "ubuntu_image_file1_id" {
  type = string
}

variable "ubuntu_image_file2_id" {
  type = string
}

variable "ubuntu_image_file3_id" {
  type = string
}

## ksg
variable "proxmox_server" {
    type = string
}

variable "ubuntu_image_file_id" {
  type = string
}