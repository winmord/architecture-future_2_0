# Terraform модуль для создания VM

## Входные параметры

| Параметр            | Описание                                                               | Обязательный | По умолчанию    |
|---------------------|------------------------------------------------------------------------|--------------|-----------------|
| `name`              | Имя виртуальной машины                                                 | Да           | -               |
| `cores`             | Количество ядер CPU                                                    | Нет          | 2               |
| `memory`            | Объём RAM в ГБ                                                         | Нет          | 4               |
| `core_fraction`     | Гарантированная доля CPU (5, 20, 50, 100)                              | Нет          | 100             |
| `platform_id`       | Платформа (standard-v1, standard-v2, standard-v3)                      | Нет          | standard-v2     |
| `boot_image_family` | Семейство образа для загрузочного диска                                | Нет          | ubuntu-2204-lts |
| `boot_disk_size`    | Размер загрузочного диска в ГБ                                         | Нет          | 30              |
| `disk_type`         | Тип диска данных (network-hdd, network-ssd, network-ssd-nonreplicated) | Нет          | network-hdd     |
| `disk_size`         | Размер диска данных в ГБ                                               | Нет          | 50              |
| `zone`              | Зона доступности (ru-central1-a, ru-central1-b, ru-central1-c)         | Нет          | ru-central1-a   |
| `subnet_id`         | ID подсети для подключения ВМ                                          | Да           | -               |
| `ssh_key`           | Публичный SSH-ключ для доступа к ВМ                                    | Да           | -               |
| `tags`              | Метки (labels) для ресурсов                                            | Нет          | {}              |

---

## Выходные параметры

| Параметр        | Описание                        |
|-----------------|---------------------------------|
| `vm_id`         | ID созданной виртуальной машины |
| `vm_name`       | Имя виртуальной машины          |
| `vm_public_ip`  | Публичный IP-адрес              |
| `vm_private_ip` | Приватный IP-адрес              |
| `data_disk_id`  | ID диска данных                 |
| `vm_fqdn`       | FQDN виртуальной машины         |

---

## Использование

### Подготовка

Необходим Terraform >= 1.0 и настроенный провайдер Yandex Cloud (переменные окружения `YC_TOKEN`
или `YC_SERVICE_ACCOUNT_KEY`).

### Развертывание окружения

Перейдите в директорию нужного окружения и выполните команды:

```bash
# Для окружения dev
cd envs/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

# Для окружения stage
cd envs/stage
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

# Для окружения prod
cd envs/prod
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"