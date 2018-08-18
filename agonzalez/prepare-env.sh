#!/bin/sh
cd /home/stack/
if [ ! -d rhte2018_kuryr ]; then
  git clone https://github.com/redhat-gpe/rhte2018_kuryr
fi
cp -a rhte2018_kuryr/instackenv.json .
rsync -avz rhte2018_kuryr/bin/ bin/
rsync -avz rhte2018_kuryr/templates/ templates/
ansible-playbook prepare-env.yaml
rsync -avz rhte2018_kuryr/devns/ devns/
cd devns/
source ~/overcloudrc
ansible-playbook --private-key ~/.ssh/id_rsa --user cloud-user deploy.yaml -e @vars.yaml
cd /home/stack
