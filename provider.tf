provider "azurerm" {
    version = "~> 1.17.0"
}

provider "random" {
    version = "~> 2.0"
}

provider "kubernetes" {
    version                 = "~> 1.3"
    host                    = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
    client_certificate      = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)}"
    client_key              = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)}"
    cluster_ca_certificate  = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)}"
}
