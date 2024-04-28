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
      address = cidrhost(var.cluster_node_network, var.ksg_worker_ip + i)
    }
  ]
}
