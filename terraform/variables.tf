variable "pm_api_url" {
  type = string
}

variable "pm_user" {
  type      = string
  sensitive = true
}

variable "pm_password" {
  type      = string
  sensitive = true
}

variable "proxmox_mini1" {
  type = string
}

variable "proxmox_mini2" {
  type = string
}

variable "proxmox_mini3" {
  type = string
}

variable "proxmox_server" {
  type = string
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "cluster_node_network" {
  type    = string
  default = "192.168.219.0/24"
}

variable "cluster_node_network_gateway" {
  type    = string
  default = "192.168.219.1"
}

## KSG Cluster Vars
variable "ksg_master_count" {
  type    = number
  default = 3
  validation {
    condition     = var.ksg_master_count >= 1
    error_message = "Must be 1 or more."
  }
}

variable "ksg_worker_count" {
  type    = number
  default = 1
  validation {
    condition     = var.ksg_worker_count >= 1
    error_message = "Must be 1 or more."
  }
}

variable "ksg_master_ip" {
  type    = number
  default = 50
}

variable "ksg_worker_ip" {
  type    = number
  default = 53
}

## YG Cluster Vars
variable "yg_master_count" {
  type    = number
  default = 2
  validation {
    condition     = var.yg_master_count >= 1
    error_message = "Must be 1 or more."
  }
}

variable "yg_worker_count" {
  type    = number
  default = 2
  validation {
    condition     = var.yg_worker_count >= 1
    error_message = "Must be 1 or more."
  }
}

variable "yg_master_ip" {
  type    = number
  default = 60
}

variable "yg_worker_ip" {
  type    = number
  default = 62
}