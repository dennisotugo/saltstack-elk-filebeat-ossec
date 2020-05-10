# vagrant-salt-ubuntu-18.04

Vagrant scripts and configuration to setup 1 salt master with 2 salt minions, and salt repos, for Ubuntu bionic 18.04


Pre-Configuration:

* Clone this repository to a directory for vagrant to use on your laptop

* cd into the repo directory
```
cd vagrant-salt-ubuntu-18.04
```

* Bring up vagrant instances
```
vagrant up
```

* place your private ssh key in the cloned repo directory for vagrant to use. This will be the key setup with our gitlab repository, so the vagrant instance can pull down the repo data.

(you may need to vagrant install the vagrant scp plugin)
```
vagrant-scp ~/.ssh/id_rsa salt-master:~/
```

* Copy your ssh key into roots .ssh directory and setup a .ssh/config for it to be used with gitlab

* Verify the pillar roots and salt root exist with the cloned repos
```
ls -al /data/pillar
ls -al /data/salt
```

* Restart Salt
```
service salt-master restart
```

* Accept minion keys
```
sudo salt-key -A
```

* Test salt across minions
```
salt '*' cmd.run 'ping -c 4 salt-master'
```









