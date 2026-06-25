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
  description = "CPU core fraction"
  type        = number
  default     = 100
}

variable "platform_id" {
  description = "Platform ID for VM"
  type        = string
  default     = "standard-v2"
}

variable "boot_image_family" {
  description = "Family of the boot image"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 30
}

variable "disk_type" {
  description = "Type of the data disk"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Size of the data disk in GB"
  type        = number
  default     = 50
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "ssh_key" {
  description = "Public SSH key"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Resource labels"
  type        = map(string)
  default     = {}
}