locals {
## YG Local Values
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

## Waji Local Values
  waji_master_nodes = [
    for i in range(1, var.waji_master_count + 1) : {
      name    = "wa-master0${i}"
      address = cidrhost(var.cluster_node_network, var.waji_master_ip + i)
    }
  ]
  waji_worker_nodes = [
    for i in range(1, var.waji_worker_count + 1) : {
      name    = "wa-worker0${i}"
      address = cidrhost(var.cluster_node_network, var.waji_worker_ip + i)
    }
  ]

## Talos Configuration
  common_machine_config = {
    machine = {
      features = {
        kubePrism = {
          enabled = true
          port    = 7445
        }
      }
    }
    cluster = {
      discovery = {
        enabled = true
        registries = {
          kubernetes = {
            disabled = false
          }
          service = {
            disabled = true
          }
        }
      }
      network = {
        cni = {
          name = "none"
        }
      }
      proxy = {
        disabled = true
      }
    }
  }
}
