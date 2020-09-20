# AndreyAndreevich_infra
AndreyAndreevich Infra repository

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
testapp_IP = 84.201.148.88
testapp_port = 9292

Для создания VM и запуска приложения на нем нужно выполнить команду: `./create_vm.sh`
