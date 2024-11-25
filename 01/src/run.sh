#!/usr/bin/env bash
docker compose up -d
cd playbook
ansible-playbook -i inventory/prod.yml site.yml
docker compose down