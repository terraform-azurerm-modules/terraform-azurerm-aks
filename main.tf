locals {
    cluster_name          	= "aks-${random_string.aks.result}"

    default_ssh_public_key	= "${file("~/.ssh/id_rsa.pub")}"
    ssh_public_key        	= "${var.ssh_public_key != "" ? var.ssh_public_key : local.default_ssh_public_key }"
}

module "service_principal" {
    source 	= "service_principal"
    sp_name	= "${local.cluster_name}"
}

resource "azurerm_resource_group" "aks" {
    name    	= "${var.resource_group_name}"
    location	= "${var.location}"
}

resource "random_string" "aks" {
    length  = 8
    lower   = true
    number  = true
    upper   = true
    special = false
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = "${local.cluster_name}"
    location            = "${azurerm_resource_group.aks.location}"
    resource_group_name = "${azurerm_resource_group.aks.name}"
    dns_prefix          = "${local.cluster_name}"
    depends_on          = [
        "module.service_principal"
    ]

    linux_profile {
        admin_username  = "aksadmin"

        ssh_key {
            key_data	= "${local.ssh_public_key}"
        }
    }

    agent_pool_profile {
        name            = "default"
        count           = "${var.agent_count}"
        vm_size         = "${var.vm_size}"
        os_type         = "Linux"
        os_disk_size_gb = 30
    }

    service_principal {
        client_id       = "${module.service_principal.client_id}"
        client_secret   = "${module.service_principal.client_secret}"
    }

    tags = "${var.tags}"
}
