# lushndm_infra
lushndm Infra repository
### Homework-03 (cloud-bastion)
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

### Homework-04 (cloud-testapp)
#### 1. Используемая команда gcloud для startup_script:
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
  --metadata-from-file startup-script=startup_script.sh
```
#### 2. Используемая команда gcloud для правила default-puma-server:
```
gcloud compute --project=infra-207413 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```
#### 3. Конфигурация и данные для подключения:
```
testapp_IP = 35.205.166.38
testapp_port = 9292
```
