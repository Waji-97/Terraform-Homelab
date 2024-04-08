module "control_plane" {
  source                = "./modules/control_plane"
  proxmox_mini1         = var.proxmox_mini_pc1
  proxmox_mini2         = var.proxmox_mini_pc2
  proxmox_mini3         = var.proxmox_mini_pc3
  ssh_key               = var.ssh_key
  ubuntu_image_file1_id = module.images.ubuntu_cloud_image_mini1_id
  ubuntu_image_file2_id = module.images.ubuntu_cloud_image_mini2_id
  ubuntu_image_file3_id = module.images.ubuntu_cloud_image_mini3_id
}

module "worker_node" {
  source               = "./modules/worker_node"
  proxmox_server       = var.proxmox_server_pc
  ssh_key              = var.ssh_key
  ubuntu_image_file_id = module.images.ubuntu_cloud_image_pve_id
}

module "load_balancer" {
  source               = "./modules/load_balancer"
  proxmox_server       = var.proxmox_server_pc
  ssh_key              = var.ssh_key
  ubuntu_image_file_id = module.images.ubuntu_cloud_image_pve_id
}

module "images" {
  source         = "./modules/images"
  proxmox_mini1  = var.proxmox_mini_pc1
  proxmox_mini2  = var.proxmox_mini_pc2
  proxmox_mini3  = var.proxmox_mini_pc3
  proxmox_server = var.proxmox_server_pc
}