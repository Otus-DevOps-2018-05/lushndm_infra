# lushndm_infra
lushndm Infra repository
#### 1. Cпособ подключения к someinternalhost в одну команду из вашего рабочего устройства:
```
ssh -i ~/.ssh/appuser -J appuser@35.206.177.86 appuser@10.132.0.3
```
#### 2. Доп. задание:
На моей локальной машине необходимо добавить в _~/.ssh/config_
```
Host bastion
    User appuser
    Hostname 35.206.177.86
    Port 22
    IdentityFile ~/.ssh/appuser
    ForwardAgent yes
Host someinternalhost
    User appuser
    Hostname 10.132.0.3
    Port 22
    ForwardAgent yes
    ProxyCommand ssh bastion 'nc %h %p'
```
#### 3. Конфигурация и данные для подключения:
```
bastion_IP = 35.206.177.86
someinternalhost_IP = 10.132.0.3
```
