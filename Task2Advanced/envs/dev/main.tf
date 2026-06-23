terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "tf-state-future20"
    key            = "dev/terraform.tfstate"
    endpoint       = "https://storage.yandexcloud.net"
    region         = "ru-central1"
    access_key     = var.access_key
    secret_key     = var.secret_key
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_request_payload_checksum = true
  }

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.120.0"
    }
  }
}

provider "yandex" {
  zone     = var.zone
  token    = var.yc_token
  cloud_id = var.cloud_id
  folder_id = var.folder_id
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