# Интеграция с CI/CD и удалённым хранением состояния

Модуль для создания виртуальной машины в Yandex Cloud с использованием GitLab CI/CD и удалённого хранения состояния в
S3-совместимом хранилище.

---

## Использование модуля

Модуль создаёт виртуальную машину с подключенным диском данных.

```hcl
module "vm" {
  source = "../../modules/vm"

  name              = "dev-vm-01"
  cores             = 2
  memory            = 4
  core_fraction     = 50
  platform_id       = "standard-v2"
  boot_image_family = "ubuntu-2204-lts"
  boot_disk_size    = 30
  disk_type         = "network-hdd"
  disk_size         = 50
  zone              = "ru-central1-a"
  subnet_id         = "subnet-12345"
  ssh_key           = "ssh-rsa AAAAB3..."
  tags = {
    Environment = "dev"
  }
}
```

### Входные параметры

| Параметр            | Описание                                          | Обязательный |
|---------------------|---------------------------------------------------|--------------|
| `name`              | Имя ВМ                                            | Да            |
| `cores`             | Количество ядер CPU                               | Нет            |
| `memory`            | RAM в ГБ                                          | Нет            |
| `core_fraction`     | Доля CPU (5, 20, 50, 100)                         | Нет            |
| `platform_id`       | Платформа (standard-v1, standard-v2, standard-v3) | Нет            |
| `boot_image_family` | Семейство образа ОС                               | Нет            |
| `boot_disk_size`    | Размер загрузочного диска в ГБ                    | Нет            |
| `disk_type`         | Тип диска данных (network-hdd, network-ssd)       | Нет            |
| `disk_size`         | Размер диска данных в ГБ                          | Нет            |
| `zone`              | Зона доступности                                  | Нет            |
| `subnet_id`         | ID подсети                                        | Да            |
| `ssh_key`           | Публичный SSH-ключ                                | Да            |
| `tags`              | Метки ресурсов                                    | Нет            |

### Выходные параметры

| Параметр        | Описание           |
|-----------------|--------------------|
| `vm_id`         | ID ВМ              |
| `vm_name`       | Имя ВМ             |
| `vm_public_ip`  | Публичный IP-адрес |
| `vm_private_ip` | Приватный IP-адрес |
| `data_disk_id`  | ID диска данных    |
| `vm_fqdn`       | FQDN ВМ            |

---

## Настройка удалённого бэкенда

В каждом окружении настроен бэкенд для хранения состояния в S3-совместимом хранилище.

```hcl
terraform {
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
}
```

---

## Настройка CI/CD

### Переменные GitLab

В **Settings - CI/CD - Variables** добавьте:

| Переменная                 | Описание                  |
|----------------------------|---------------------------|
| `TF_VAR_yc_token`          | OAuth-токен Yandex Cloud  |
| `TF_VAR_cloud_id`          | ID облака                 |
| `TF_VAR_folder_id`         | ID папки                  |
| `TF_VAR_access_key`        | S3 Access Key             |
| `TF_VAR_secret_key`        | S3 Secret Key             |
| `TF_VAR_subnet_id`         | ID подсети                |
| `TF_VAR_ssh_key`           | Публичный SSH-ключ        |
| `TF_VAR_name`              | Имя ВМ                    |
| `TF_VAR_cores`             | Количество ядер           |
| `TF_VAR_memory`            | RAM в ГБ                  |
| `TF_VAR_core_fraction`     | Доля CPU                  |
| `TF_VAR_platform_id`       | Платформа                 |
| `TF_VAR_boot_image_family` | Семейство образа          |
| `TF_VAR_boot_disk_size`    | Размер загрузочного диска |
| `TF_VAR_disk_type`         | Тип диска данных          |
| `TF_VAR_disk_size`         | Размер диска данных       |
| `TF_VAR_zone`              | Зона доступности          |

### Локальный запуск

```bash
cd envs/dev
cp terraform.tfvars.example terraform.tfvars
# Заполните terraform.tfvars
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Запуск через CI/CD

1. Пуш в `develop` - автоматический план для dev
2. Пуш в `main` - автоматический план для всех окружений
3. Deploy запускается вручную через интерфейс GitLab

---

## Сравнение окружений

| Параметр          | DEV                   | STAGE                   | PROD                   |
|-------------------|-----------------------|-------------------------|------------------------|
| Ядра CPU          | 2                     | 4                       | 8                      |
| RAM (ГБ)          | 4                     | 8                       | 16                     |
| Доля CPU          | 50%                   | 100%                    | 100%                   |
| Тип диска         | network-hdd           | network-ssd             | network-ssd            |
| Размер диска (ГБ) | 50                    | 100                     | 200                    |
| State-файл        | dev/terraform.tfstate | stage/terraform.tfstate | prod/terraform.tfstate |

---

## Безопасность

- Все секреты хранятся в защищённых переменных GitLab CI/CD
- `.tfvars` файлы не попадают в репозиторий
- State-файлы не хранятся локально
- Deploy в stage/prod требует ручного подтверждения