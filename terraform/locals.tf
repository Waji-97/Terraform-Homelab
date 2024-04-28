locals {
  ksg_master_nodes = [
    for i in range(1, var.ksg_master_count + 1) : {
      name    = "ksg-master0${i}"
      address = cidrhost(var.cluster_node_network, var.ksg_master_ip + i)
    }
  ]
  ksg_worker_nodes = [
    for i in range(1, var.ksg_worker_count + 1) : {
      name    = "ksg-worker0${i}"
      address = cidrhost(var.cluster_node_network, var.yg_worker_ip + i)
    }
  ]
  yg_master_nodes = [
    for i in range(1, var.yg_master_count + 1) : {
      name    = "yg-master0${i}"
      address = cidrhost(var.cluster_node_network, var.yg_master_ip + i)
    }
  ]
  yg_worker_nodes = [
    for i in range(1, var.yg_worker_count + 1) : {
      name    = "yg-worker0${i}"
      address = cidrhost(var.cluster_node_network, var.yg_worker_ip + i)
    }
  ]
}
