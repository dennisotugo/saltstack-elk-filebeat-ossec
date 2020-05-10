filebeat_repository:
  pkgrepo.managed:
    - humanname: filebeat
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

filebeat:
  pkg.installed:
    - name: filebeat
    - require:
      - pkgrepo: filebeat_repository

filebeat_conf:
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - source: salt://beats/files/filebeat/filebeat.yml
    - template: jinja
    - logstash_hosts: {{ ','.join(salt['pillar.get']('filebeat:logstash:hosts')) }}


filebeat_service:
  service.running:
    - name: filebeat
    - enable: True
    - reload: True
    - require:
      - pkg: filebeat