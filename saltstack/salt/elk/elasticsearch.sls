elasticsearch_repository:
  pkgrepo.managed:
    - humanname: elasticsearch
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
      
elasticsearch_install:
  pkg.installed:
    - name: elasticsearch
    - refresh: True
    - require:
      - pkgrepo: elasticsearch_repository
    - failhard: True

elasticsearch_config:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://elk/files/elasticsearch.yml.conf
    - template: jinja
    - watch_in:
      - service: elasticsearch_service

elasticsearch_service:
  service.running:
    - name: elasticsearch
    - enable: True
    - reload: True
    - require:
      - pkg: elasticsearch

kibana_install:
  pkg.installed:
    - name: kibana
    - refresh: True
    - require:
      - pkgrepo: elasticsearch_repository
    - failhard: True

kibana_config:
  file.managed:
    - name: /etc/kibana/kibana.yml
    - source: salt://elk/files/kibana.yml.conf
    - template: jinja
    - elasticsearch_hosts: {{ ','.join(salt['pillar.get']('filebeat:elasticsearch:hosts')) }}
    - watch_in:
      - service: kibana_service

kibana_service:
  service.running:
    - name: kibana
    - enable: True
    - reload: True
    - require:
      - pkg: kibana

logstash_install:
  pkg.installed:
    - name: logstash
    - refresh: True
    - require:
      - pkgrepo: elasticsearch_repository
    - failhard: True

logstash_config:
  file.managed:
    - name: /etc/logstash/conf.d/filebeat.conf
    - source: salt://elk/files/logstash.yml.conf
    - template: jinja
    - logstash_hosts: {{ ','.join(salt['pillar.get']('filebeat:logstash:hosts')) }}
    - watch_in:
      - service: logstash_service

logstash_service:
  service.running:
    - name: logstash
    - enable: True
    - reload: True
    - require:
      - pkg: logstash