# lushndm_infra
lushndm Infra repository

### Homework-08 (ansible-1)
 - Установлен ansible.
 - Настроен ansible.cfg.
 - Настроен inventory.
 - Настроен inventory.yml.
 - Запущен playbook clone.yml с модулем git.
 - Выполнение плейбука clone.yml после ```ansible app -m command -a 'rm -rf ~/reddit'``` получает в ответ ```changed=1```, так как плейбук скопировал репозиторий в папку ~/redddit из-за его отсутствия на хосте appsever.
 - * Реализован динамический inventory через inventory.json и inventory.sh.
 
### Homework-07 (terraform-2)
 - Added default-allow-ssh rule into main.tf. And imported default-allow-ssh rule into tfstate.
 - Added resource google_compute_address в main.tf. And link it to access_config in app instance.
 - Added app.json, db.json and app.tf, db.tf, vpc.tf. Edited main.tf and variables.tf.
 - Added modules app, db and vpc. Deleted app.tf, db.tf and vpc.tf.
 - Initialized prod and stage enviroments.
 - Initialized storage-bucket module.
 - Renamed storage bucket at storage-bucket.tf. Added backend.tf to stage and prod folders. Deleted terraform.tfstate files from local machine.
 - Added provisioners to app's main.tf for deploying app. Added db_internal_ip to variables. Added puma.service.tpl.

#### Terraform Backend*:
После настройки backend'a terraform "видит" текущее состояние независимо от директории, в которой запускается.
При попытке одновременного применения конфигурации terraform указывает на блокировку.
#### Provisioners*:
 - Добавлен provisioner data "template_file" "pumaservice" для передачи адреса БД в приложение.
 - Добавлен provisioner "file" для передачи файла на хост на основе шаблона puma.service.tpl.
 - Добавлен provisioner "remote-exec", который запускает скрипт deploy.sh для деплоя и работы приложения.

### Homework-06 (terraform-1)
#### 1. Установка Terraform:
Установил Terraform.
Добавил необходимые файлы в .gitignore.
#### 2. Инициализация Terraform:
Создал main.tf с определением секции provider.
Запустил terraform init.
#### 3. Определение ресурсов в Terraform:
Определил google_compute_instance в main.tf.
Выполнил terraform apply.
Определил SSH ключ пользователя appuser в метаданных нашего инстанса.
Добавил "app_external_ip" в outputs.tf.
Определил google_compute_firewall в main.tf.
#### 4. Определение provisioners в Terraform:
Добавил передачу файла puma.service через main.tf.
Добавил remote-exec в main.tf для запуска скрипта deploy.sh на инстансе.
#### 5. Определение входных переменных в Terraform:
Добавил переменные в variables.tf и скорректировал main.tf.
Определил переменные используя специальный файл terraform.tfvars.
Создал для образца terraform.tfvars.example.
#### 6. Задание со * в terraform-1:
Описал в коде терраформа добавление ssh ключей нескольких пользователей в метаданные проекта.
При запуске terraform apply удаляются ssh ключи, добавленные через веб интерфейс.
#### 7. Задание с ** в terraform-1:
Описал в lb.tf в коде terraform создание HTTP балансировщика, направляющего трафик на наше развернутое приложение на инстансах reddit-app.
Копированием кода добавил второй инстанс. Что нерационально, плюс нужно следить за именем инстанса для добавления адреса в output переменные.
Применил подход с заданием количества инстансов через параметр ресурса count.

### Homework-05 (packer-base)
#### 1. Ubuntu16.json (fried VM):
На основе шаблона ubuntu16.json создал образ.
На основе этого образа запустил инстанс, и запустил на нем приложение.
#### 2. Параметризация шаблона:
Добавил пользовательские переменные в шаблон ubuntu16.json.
Добавил пользовательские переменные в variables.json.
#### 3. Immutable.json (baked VM):
Через шаблон immutable.json "запёк” (bake) в образ VM все зависимости приложения и сам код приложения.
Добавил puma.service в systemd образа VM.
Создал shell-скрипт create-reddit-vm.sh для запуска VM с помощью командной строки и утилиты gcloud.

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
