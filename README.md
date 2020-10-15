[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/AndreyAndreevich_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/AndreyAndreevich_infra)

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

## Homework №7 (terraform-2)

* Сборка образа с приложением: `packer build -var-file="./packer/variables.json" ./packer/app.json`
* Сборка образа с базой данных: `packer build -var-file="./packer/variables.json" ./packer/db.json`
* Созданы terraform модули: app, db, vpc
* Созданы окружения: prod, stage, vpc
* Добавил `backend.tf` в папки prod и stage. В качестве проверки использовал те же окружения,
т.к. они полностью идетичны.
Если выполнить последовательно `terraform apply` в prod и в dev, то инстансы будут созданы только
для prod. Для dev же будут использованы инстансы prod.
Если выполнить параллельно `terraform apply` в prod и в dev, то в одном из вызовов будет выполнено
создание инстансов, а в другом нет (вызов авершится ошибкой). Может даже произойти такое, что в
одном из вызовов раньше будетсоздан инстанс `app`, а в другом `db`. В итоге оба вызова завершатся
с ошибкой.
* Добавил файлы для запуска приложения в модуль `app`
* Заменил `puma.service` на `puma.service.template`
* Добавил экспорт переменной `DATABASE_URL` в `provission` `app`
* Добавлил проброс переменной `db_addr` из `db` в `app`
* В модуль `db` добавил изменение конфига mongo

## Homework №8 (ansible-1)

* Поставлен `ansible`
* Поднято окружение с помощью `terraform`
* Выполнил ping для `appserver` и `dbserver`. Пришлось выставить `ansible_python_interpreter=/usr/bin/python3`
* Создал `ansible.cfg`
* Заменил `inventory` на `inventory.yml`
* При первом клнировании в home dir уже был `reddit`
* Добавли скрипт для динамического создания `inventory.json`

## Homework №9 (ansible-2)

* Обновлена конфигурация монго с помощью `ansible-playbook reddit_app.yml --limit db`
* Задеплоил app с помощью
```
ansible-playbook reddit_app.yml --limit app --tags app-tag
ansible-playbook reddit_app.yml --limit app --tags deploy-tag
```
* Написал несколько сценариев в одном playbook `reddit_app_multiple_plays.yml` и проверил их работу с помощью тегов
* Разделили playbook `reddit_app_multiple_plays.yml` на три и проверил `ansible-playbook site.yml`
* Добавил проброс `internal_ip_address_db` из terraform в ansible playbook через dinamyc inventory
* Собрал образы packer-ом c помощью ansible provisioners, создал из них основе VM и развернул приложение с бд
* Для удобства stage теперь создает vpc

## Homework №10 (ansible-3)

* Создал роли для `app` и `db`
* Настроил `stage` и `prod` окружения
* Добавил роль nginx и проверил работу приложения на 80 порту через nginx
* Создал пользователей с помощью `users.yml` playbook и vault
* Использую dynamic inventory для `prod` и `stage`
* Добавил валидацию packer, terraform и ansible в CI
* Добавил build status в Readme
