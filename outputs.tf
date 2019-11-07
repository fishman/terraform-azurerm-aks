output "client_key" {
  value = module.kubernetes.client_key
}

output "client_certificate" {
  value = module.kubernetes.client_certificate
}

output "cluster_ca_certificate" {
  value = module.kubernetes.cluster_ca_certificate
}

output "host" {
  value = module.kubernetes.host
}

output "username" {
  value = module.kubernetes.username
}

output "password" {
  value = module.kubernetes.password
}

output "node_resource_group" {
  value = module.kubernetes.node_resource_group
}

output "location" {
  value = module.kubernetes.location
}

output "kube_admin_config_raw" {
  value = module.kubernetes.kube_admin_config_raw
}

output "kube_config_raw" {
  value = module.kubernetes.kube_config_raw
}
