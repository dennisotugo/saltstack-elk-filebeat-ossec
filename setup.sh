#!/bin/bash

# Install Docker Engine pre-requisites
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

# Install Docker Engine
apt-key add /vagrant/docker-gpg-key


## current repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# ubuntu 14 repo:
# echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list

apt-get update
## install a version
# apt-get install -y docker-engine=1.8.3-0~trusty
#
apt-get install docker-ce

# install python stuff
apt-get install python python-dev python-virtualenv
