variable "name" {
  description = "VM name"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of RAM in GB"
  type        = number
  default     = 4
}

variable "core_fraction" {
  description = "CPU core fraction (5, 20, 50, 100)"
  type        = number
  default     = 100
}

variable "platform_id" {
  description = "Platform ID for VM (standard-v1, standard-v2, standard-v3)"
  type        = string
  default     = "standard-v2"
}

variable "boot_image_family" {
  description = "Family of the boot image (e.g., ubuntu-2204-lts)"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 30
}

variable "disk_type" {
  description = "Type of the data disk (network-hdd, network-ssd, network-ssd-nonreplicated)"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Size of the data disk in GB"
  type        = number
  default     = 50
}

variable "zone" {
  description = "Availability zone (ru-central1-a, ru-central1-b, ru-central1-c)"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_id" {
  description = "ID of the subnet for VM attachment"
  type        = string
}

variable "ssh_key" {
  description = "Public SSH key for VM access"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Labels to apply to resources"
  type        = map(string)
  default     = {}
}