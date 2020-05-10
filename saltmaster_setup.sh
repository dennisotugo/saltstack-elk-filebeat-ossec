#!/bin/bash

apt-get -y install git
git clone https://github.com/saltstack/salt-bootstrap.git 
cd salt-bootstrap
sudo sh bootstrap-salt.sh -M  git v2017.7


## setup file roots with git repo ##
#mkdir /data/
#cd /data/
#
#git clone ssh://git@gitlab.catalyze.io:2202/salt/salt-states.git && {
#  ln -s salt-states salt && {
#    cd /data/salt 
#    git checkout COPS-2792_UBUNTU-18.04
#  }
#}
#
#git clone ssh://git@gitlab.catalyze.io:2202/salt/salt-pillar-sbox05.git && {
#  ln -s salt-pillar-sbox05 pillar && {
#    cd /data/pillar
#    git checkout COPS-2792_UBUNTU-18.04
#  }
#}
#

cat << EOF >> /etc/salt/master
file_roots:
  base:
    - /data/salt/

log_level: info
log_fmt_logfile: 'salt-log %(asctime)s,%(msecs)03d [%(name)-17s][%(levelname)-8s] %(message)s'

pillar_roots:
  base:
    - /data/pillar

#redis.db: 0
#redis.host: localhost
#redis.port: 6379

ext_pillar:
  - redis: {function: key_json}

client_acl:
  drone:
    - .*

external_auth:
  pam:
    infrastructure%:
      - .*
EOF

cat << EOF >> /etc/salt/grains
grains:
 cloud_provider: vagrant
 pod_id: sbox05
 os: Linux

EOF

service salt-master restart
