#!/bin/bash


#curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
apt-get install git
git clone https://github.com/saltstack/salt-bootstrap.git
cd salt-bootstrap
sudo sh bootstrap-salt.sh git v2017.7

sysctl -w vm.max_map_count=262144
echo "192.168.160.100    salt-master" >> /etc/hosts

cat << EOF >> /etc/salt/minion
master: salt-master
id:  minion02
grains:
  pod_id: sbox05
  pod_type: sbox
  ebs_disk: true
  cloud_provider: vagrant
  overlay_subnet: 192.168.1.0/24
  web_host: true
  no_orch_tls: true
  resources: true
  pod-router: true
  product: true
  core-api: true
  postgresql_master: true
  notary_server: true
  notary_signer: true
  zone_enabled: true
  custom_requires: job.web_vpc
  versions:
  linux_image:
  roles:
    - memcache
EOF
service salt-minion restart
