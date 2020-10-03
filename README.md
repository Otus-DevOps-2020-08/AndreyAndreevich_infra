# AndreyAndreevich_infra
AndreyAndreevich Infra repository

## Homework №3

`ssh -J bastion someinternalhost`

Нужно выполнить проброс портов через ssh на обоих тачках.
1. Выполнить на своей тачке: `ssh -L 22222:localhost:22222 -A -N -f bastion`
2. Выполнить на bastion: `ssh -L 22222:localhost:22 -A -N -f someinternalhost`
3. Добавить в `~/.ssh/config` на своей тачке:
```
Host someinternalhost
User andrey
Port 22222
HostName localhost
```
4. Запустить `ssh someinternalhost`

## Bastion configuration
bastion_IP = 130.193.56.192
someinternalhost_IP = 10.128.0.35

## Homework №4 (cloud-testapp)
testapp_IP = 130.193.57.24
testapp_port = 9292

Для создания VM и запуска приложения на нем нужно выполнить команду: `./create_vm.sh`

## Homework №5 (packer-base)

* Создание базового образа: `packer build -var-file="./variables.json" ./ubuntu16.json`
* Создание полного образа: `packer build -var-file="./variables.json" ./immutable.json`
* Создание VM из полного образа: `./config-script/config-scripts/create-reddit-vm.sh`

Проблемы с сетью решил путем добавления `subnet_id` в конфиг

## Homework №6 (terraform-1)

1. Создана app VM "reddit-app" с помощью terraform
2. Создан load balancer "reddit-lb" с помощью terraform
3. Создана app VM "reddit-app2" и проверена балансировка нагрузки
4. Добавлено динамическое создание инстансов через set

## Homework №6 (terraform-2)

* Сборка образа с приложением: `packer build -var-file="./variables.json" ./app.json`
* Сборка образа с базой данных: `packer build -var-file="./variables.json" ./db.json`
* Созданы terraform модули: app, db, vpc
* Созданы окружения: prod, stage, vpc
