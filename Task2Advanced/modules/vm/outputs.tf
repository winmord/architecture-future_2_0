output "vm_id" {
  description = "VM ID"
  value       = yandex_compute_instance.vm.id
}

output "vm_name" {
  description = "VM name"
  value       = yandex_compute_instance.vm.name
}

output "vm_public_ip" {
  description = "Public IP address"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "vm_private_ip" {
  description = "Private IP address"
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "data_disk_id" {
  description = "Data disk ID"
  value       = yandex_compute_disk.data_disk.id
}

output "vm_fqdn" {
  description = "FQDN of the VM"
  value       = yandex_compute_instance.vm.fqdn
}