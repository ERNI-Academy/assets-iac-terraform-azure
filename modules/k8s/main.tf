// This module creates an AKS
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources

locals {
 k8s_name = "${var.k8s_name}-${var.environment}"
 dns_name = "${var.k8s_name}-${var.environment}"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = local.k8s_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = local.dns_name
  

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    vm_size    = var.default_node_pool_vm_size
    os_disk_size_gb = var.default_node_pool_disk_size_gb
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}