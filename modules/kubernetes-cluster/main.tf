resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.prefix
  kubernetes_version  = var.kubernetes_version

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = replace(var.admin_public_ssh_key, "\n", "")
    }
  }

  default_node_pool {
    name            = "nodepool"
    node_count      = var.agents_count
    vm_size         = var.agents_size
    os_disk_size_gb = 50
    vnet_subnet_id  = var.subnet_id
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  addon_profile {
    # This is the default
    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # Enable Advanced Networking
  dynamic "network_profile" {
    for_each = [for s in var.network_profiles : {
      network_plugin     = s.network_plugin
      service_cidr       = s.service_cidr
      dns_service_ip     = s.dns_service_ip
      docker_bridge_cidr = s.docker_bridge_cidr
    }]

    content {
      network_plugin     = network_profile.value.network_plugin
      service_cidr       = network_profile.value.service_cidr
      dns_service_ip     = network_profile.value.dns_service_ip
      docker_bridge_cidr = network_profile.value.docker_bridge_cidr
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool
    ]
  }

  tags = var.tags
}
