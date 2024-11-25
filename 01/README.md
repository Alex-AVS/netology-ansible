# 01.  Введение в Ansible
Работаем в ВМ Debian 12, версии Ansible и Docker:

![tf](img/01-00-versions.png)

## Задание 1
1. Выполняем Playbook. Полоучили значение *12*:

![tf](img/01-01-play-1.png)

2. Данное значение задон в файле `group_vars/all/examp.yml`. Меняем на *all default fact* и выполняем снова:

![tf](img/01-01-play-2.png)

Изменилось.

3. Создаём [compose-file](src/compose.yaml) и запускаем два контейнера с CentOS7 и Ubuntu 22.04 c , предварительно установленным python

![tf](img/01-01-docker_env_up.png)

4. Выполняем playbook с окружением prod:

![tf](img/01-01-play-3.png)

5,6. Поменяли значения в `src/deb/examp.yml` `src/el/examp.yml`:

![tf](img/01-01-play-4.png)

7. Зашифровали факты с помощью `ansible-vault`:

![tf](img/01-01-vault-encrypt.png)

Результат:

![tf](img/01-01-vault-encrypted.png)

8. Выполняем playbook. Просто так не работает, нужно указать ключ, чтобы спросили пароль:

![tf](img/01-01-play-5.png)

9. Смотрим список коннекторов:

![tf](img/01-01-ans-doc-ls.png)

Очевидно, нам нужен `ansible.builtin.local`.

10. Добавили localhost в окружение prod:
```yaml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```
11. Выполняем:

![tf](img/01-01-play-6.png)

## Задание 2
1. Расшифровываем файлы:

![tf](img/01-02-vault-decrypt.png)

2. Шифруем строку:

![tf](img/01-02-vault-sring-encrypt.png)

3. Выполняем:

![tf](img/01-02-play-1.png)

4. Добавляем в окружение контейнер с fedora:
```yaml
fedora:
    container_name: 'fedora'
    stdin_open: true
    tty: true
    image: pycontribs/fedora:latest
    command: bash
```
Запускаем:

![tf](img/01-02-docker-up.png)

Добавляем группу хостов fed и переменную some_fact. Выполняем playbook:

![tf](img/01-02-play-2.png)

5. Создаём [скрипт](src/run.sh) для запуска и выполняем:

![tf](img/01-02-run-sh.png)