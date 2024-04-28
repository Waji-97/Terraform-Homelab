locals {
  ksg_master_nodes = [
    for i in range(var.master_count) : {
      name    = "ksg-master0${i}"
      address = cidrhost(var.cluster_node_network, var.ksg_master_ip + i)
    }
  ]
  ksg_worker_nodes = [
    for i in range(var.worker_count) : {
      name    = "ksg-worker0${i}"
      address = cidrhost(var.cluster_node_network, var.ksg_worker_ip + i)
    }
  ]
}