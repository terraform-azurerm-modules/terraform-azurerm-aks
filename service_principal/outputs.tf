output "sp_id" {
  value = "${azurerm_azuread_service_principal.aks_sp.id}"
}

output "client_id" {
  value = "${azurerm_azuread_service_principal.aks_sp.application_id}"
}

output "client_secret" {
  sensitive = true
  value     = "${random_string.aks_sp_password.result}"
}
