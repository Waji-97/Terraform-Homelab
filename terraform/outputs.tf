output "talosconfig" {
  value     = data.talos_client_configuration.talos.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = data.talos_cluster_kubeconfig.talos.kubeconfig_raw
  sensitive = true
}

output "controllers" {
  value = join(",", [for node in local.waji_master_nodes : node.address])
}

output "workers" {
  value = join(",", [for node in local.waji_worker_nodes : node.address])
}