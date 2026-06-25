terraform {
  required_version = ">= 1.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}

module "vm" {
  source = "../../modules/vm"

  name              = var.name
  cores             = var.cores
  memory            = var.memory
  core_fraction     = var.core_fraction
  platform_id       = var.platform_id
  boot_image_family = var.boot_image_family
  boot_disk_size    = var.boot_disk_size
  disk_type         = var.disk_type
  disk_size         = var.disk_size
  zone              = var.zone
  subnet_id         = var.subnet_id
  ssh_key           = var.ssh_key
  tags              = var.tags
}