ossec_repository:
  pkgrepo.managed:
    - humanname: atomicorp
    - name: deb https://updates.atomicorp.com/channels/atomic/ubuntu bionic main
    - dist: bionic
    - file: /etc/apt/sources.list.d/atomic.list
    - gpgcheck: 1
    - key_url: https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt
      
ossec_install:
  pkg.installed:
    - name: ossec-hids-server
    - refresh: True
    - require:
      - pkgrepo: ossec_repository
    - failhard: True

ossec_agent_install:
  pkg.installed:
    - name: ossec-hids-agent
    - refresh: True
    - require:
      - pkgrepo: ossec_repository
    - failhard: True