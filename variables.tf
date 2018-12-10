variable "resource_group_name" {
   default =   "aks"
}

variable "location" {
   default =   "westeurope"
}

variable "ssh_public_key" {
   type         = "string"
   default      = ""
   description  = "Public key for aksadmin's SSH access.  Will default to the contents of ~/.ssh/id_rsa.pub."
}

variable "agent_count" {
   default =   2
}

variable "vm_size" {
   default =   "Standard_DS2_v2"
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "testing"
    }
}