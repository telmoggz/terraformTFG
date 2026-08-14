output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the virtual machine."
}

output "vm_private_ip" {
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "The private IP address of the virtual machine."
}

output "vm_public_ip" {
  value       = var.create_public_ip ? azurerm_public_ip.public_ip[0].ip_address : null
  description = "The public IP address of the virtual machine, if created."
}
