terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.53.1"
    }
  }

  cloud {
    organization = "Waji_Homelab"

    workspaces {
      name = "Homelab-TF"
    }
  }
}

provider "proxmox" {
  username = var.pm_user
  password = var.pm_password
  endpoint = var.pm_api_url
  insecure = true

  ssh {
    agent = true
  }
}
