common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      - vim

corretto_repository:
  pkgrepo.managed:
    - humanname: JDK
    - name: deb https://apt.corretto.aws stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/corretto.list
    - gpgcheck: 1
    - key_url: https://apt.corretto.aws/corretto.key

corretto:
  pkg.installed:
    - name: java-1.8.0-amazon-corretto-jdk
    - require:
      - pkgrepo: corretto_repository