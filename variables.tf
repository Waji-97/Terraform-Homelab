variable "pm_api_url" {
  type = string
}

variable "pm_user" {
  type = string
  sensitive = true
}

variable "pm_password" {
  type = string
  sensitive = true
}

variable "proxmox_mini_pc1" {
  type = string
}

variable "proxmox_mini_pc2" {
  type = string
}

variable "proxmox_mini_pc3" {
  type = string
}

variable "proxmox_server_pc" {
  type = string
}

variable "ssh_key" {
  type = string
  sensitive = true
}
